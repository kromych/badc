
x87_control_word.x64:	file format elf64-x86-64

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
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdx, %r10
               	fnstcw	(%r10)
               	movzwq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, -0x8(%rbp)
               	movq	%rdx, %r10
               	fldcw	(%r10)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdx, %r10
               	fnstcw	(%r10)
               	movzwq	-0x8(%rbp), %rsi
               	movq	%rsi, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	cmpl	%ecx, %edx
               	je	<addr>
               	leaq	<rip>, %rdi
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movq	%rsi, %rcx
               	andq	$0xfff, %rcx            # imm = 0xFFF
               	cmpl	$0x37f, %ecx            # imm = 0x37F
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
