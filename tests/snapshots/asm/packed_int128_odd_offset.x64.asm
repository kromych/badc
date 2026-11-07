
packed_int128_odd_offset.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movabsq	$0x43ec000000000000, %rax # imm = 0x43EC000000000000
               	movabsq	$0x4020000000000000, %rcx # imm = 0x4020000000000000
               	movq	%rcx, -0x18(%rbp)
               	movsd	-0x18(%rbp), %xmm0
               	movq	%rax, %xmm14
               	vmulsd	%xmm0, %xmm14, %xmm0
               	movabsq	$0x441c000000000000, %rax # imm = 0x441C000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	leaq	0x1(%rcx), %rax
               	cmpq	%rcx, %rax
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	%rdx, %rcx
               	movq	%rax, <rip> # <addr>
               	movq	%rcx, <rip> # <addr>
               	cmpl	$0xc, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	leaq	0x1(%rcx), %rax
               	cmpq	%rcx, %rax
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	%rdx, %rcx
               	movq	%rax, <rip> # <addr>
               	movq	%rcx, <rip> # <addr>
               	cmpl	$0xd, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movq	$0xa, <rip> # <addr>
               	movq	$0xe, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0xe, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movsbq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	leave
               	retq
               	cmpq	$0xb, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
