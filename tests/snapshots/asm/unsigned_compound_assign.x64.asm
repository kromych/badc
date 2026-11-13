
unsigned_compound_assign.x64:	file format elf64-x86-64

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

<rtu>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	leave
               	retq

<rtul>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	$0x3e8, -0x8(%rbp)      # imm = 0x3E8
               	movq	-0x8(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0x64, %edi
               	callq	<addr>
               	leaq	0x5(%rax), %rsi
               	cmpl	$0x69, %esi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x3e8, %edi            # imm = 0x3E8
               	callq	<addr>
               	leaq	0x19f(%rax), %rsi
               	cmpq	$0x587, %rsi            # imm = 0x587
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x41c, %edi            # imm = 0x41C
               	callq	<addr>
               	movq	%rax, 0x8(%rsp)
               	movl	$0x502, %edi            # imm = 0x502
               	callq	<addr>
               	subq	$0x363, %rax            # imm = 0x363
               	movq	0x8(%rsp), %rsi
               	addq	%rax, %rsi
               	cmpl	$0x5bb, %esi            # imm = 0x5BB
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0xc8, %edi
               	callq	<addr>
               	andq	$0xff, %rax
               	leaq	0x3c(%rax), %rsi
               	andq	$0xff, %rsi
               	cmpl	$0x4, %esi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rax
               	xorl	%ecx, %ecx
               	movabsq	$0xa00000000, %rdx      # imm = 0xA00000000
               	movq	%rdx, -0x20(%rbp)
               	movabsq	$0x1e00000014, %rdx     # imm = 0x1E00000014
               	movq	%rdx, -0x18(%rbp)
               	movl	$0x28, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movl	0xc(%rax), %esi
               	cmpl	$0x1e, %esi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	%rcx, %rax
               	leave
               	retq
