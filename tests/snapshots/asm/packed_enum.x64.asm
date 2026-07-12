
packed_enum.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x8(%rbp), %rax
               	movl	$0x1234, %ecx           # imm = 0x1234
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x7, %ecx
               	movb	%cl, 0x2(%rax)
               	leaq	-0x8(%rbp), %rax
               	xorq	%rcx, %rcx
               	movb	%cl, 0x3(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0xab, %ecx
               	movb	%cl, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x100, %ecx            # imm = 0x100
               	movw	%cx, 0x6(%rax)
               	leaq	-0x8(%rbp), %rax
               	movzbq	0x2(%rax), %rax
               	xorq	$0x7, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movzwq	0x6(%rax), %rax
               	xorq	$0x100, %rax            # imm = 0x100
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	xorq	$0x1234, %rax           # imm = 0x1234
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movzbq	0x4(%rax), %rax
               	xorq	$0xab, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
