
float_increment_decrement.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	movl	$0x3f800000, -0x8(%rbp) # imm = 0x3F800000
               	movss	-0x8(%rbp), %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm0
               	movl	$0x40400000, %ecx       # imm = 0x40400000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	-0x10(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movsd	-0x8(%rbp), %xmm0
               	movabsq	$-0x4010000000000000, %rcx # imm = 0xBFF0000000000000
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movss	-0x10(%rbp), %xmm0
               	movl	$0x40200000, %edx       # imm = 0x40200000
               	movq	%rdx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x8(%rbp), %xmm0
               	movabsq	$0x3ff8000000000000, %rdx # imm = 0x3FF8000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, <rip> # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, <rip> # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movabsq	$0x401c000000000000, %rax # imm = 0x401C000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rdx), %r10
               	movq	%r10, 0x10(%rax)
               	movsd	-0x10(%rbp), %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	-0x8(%rbp), %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x8(%rbp), %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
