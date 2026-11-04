
range_unproved_comparisons_stay.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	movq	$0x100, <rip> # imm = 0x100
                                                # <addr>
               	movq	$0x100, <rip> # imm = 0x100
                                                # <addr>
               	xorl	%eax, %eax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	testb	$-0x1, %cl
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	leave
               	retq
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rdx
               	xorq	$0x2, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	cmpq	$0x2, %rcx
               	ja	<addr>
               	movl	$0x2, %eax
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	movl	$0x5, %eax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	-0x8(%rbp), %rcx
               	cmpq	$0x64, %rcx
               	jge	<addr>
               	movq	<rip>, %rcx # <addr>
               	movq	$0x100, (%rcx)          # imm = 0x100
               	movq	-0x8(%rbp), %rcx
               	cmpq	$0x64, %rcx
               	jge	<addr>
               	movl	$0x3, %ecx
               	testl	%ecx, %ecx
               	je	<addr>
               	movq	%rcx, %rax
               	leave
               	retq
               	movq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	jbe	<addr>
               	addq	$-0x11, %rcx
               	cmpq	$-0x11, %rcx
               	jbe	<addr>
               	movl	$0x4, %ecx
               	testl	%ecx, %ecx
               	je	<addr>
               	movq	%rcx, %rax
               	leave
               	retq
               	movq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	shlq	$0x37, %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
