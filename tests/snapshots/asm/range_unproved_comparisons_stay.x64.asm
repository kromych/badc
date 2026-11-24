
range_unproved_comparisons_stay.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x18, %rsp
               	movq	$0x100, <rip> # imm = 0x100
                                                # <addr>
               	movq	$0x100, <rip> # imm = 0x100
                                                # <addr>
               	xorl	%eax, %eax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	testb	$-0x1, %cl
               	jne	<addr>
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	movq	%rdx, %rcx
               	cmovneq	%rax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rcx # <addr>
               	cmpl	$0x2, %ecx
               	je	<addr>
               	cmpq	$0x2, %rcx
               	ja	<addr>
               	movl	$0x2, %eax
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x18, %rsp
               	retq
               	movl	$0x5, %ecx
               	movq	%rcx, 0x8(%rsp)
               	leaq	0x8(%rsp), %rax
               	movq	%rax, <rip> # <addr>
               	movq	0x8(%rsp), %rax
               	cmpq	$0x64, %rax
               	jge	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	$0x100, (%rax)          # imm = 0x100
               	movq	0x8(%rsp), %rax
               	cmpq	$0x64, %rax
               	jge	<addr>
               	movl	$0x3, %eax
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	jbe	<addr>
               	addq	$-0x11, %rax
               	cmpq	$-0x11, %rax
               	jbe	<addr>
               	movl	$0x4, %eax
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	shlq	$0x37, %rax
               	testq	%rax, %rax
               	jl	<addr>
               	testl	%ecx, %ecx
               	je	<addr>
               	movq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
