
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
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %r10
               	fnstcw	(%r10)
               	movzwq	-0x8(%rbp), %rsi
               	movw	%si, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %r10
               	fldcw	(%r10)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %r10
               	fnstcw	(%r10)
               	movzwq	-0x8(%rbp), %rdx
               	cmpl	%esi, %edx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	%rsi, %rax
               	andq	$0xfff, %rax            # imm = 0xFFF
               	cmpl	$0x37f, %eax            # imm = 0x37F
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorq	%rax, %rax
               	leave
               	retq
