
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
               	movzwq	-0x8(%rbp), %rax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rcx, %r10
               	fldcw	(%r10)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rcx, %r10
               	fnstcw	(%r10)
               	movzwq	-0x8(%rbp), %rcx
               	cmpl	%eax, %ecx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%rax, %rsi
               	movq	%rcx, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	%rax, %rcx
               	andq	$0xfff, %rcx            # imm = 0xFFF
               	cmpl	$0x37f, %ecx            # imm = 0x37F
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%rax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movq	%rax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	xorq	%rax, %rax
               	leave
               	retq
