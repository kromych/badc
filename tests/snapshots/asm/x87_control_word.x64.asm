
x87_control_word.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<get_cw>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%r13, (%rsp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %r10
               	fnstcw	(%r10)
               	movzwq	-0x8(%rbp), %rax
               	movq	(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<set_cw>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	movq	%rdi, 0x10(%rbp)
               	leaq	0x10(%rbp), %rax
               	movq	%rax, %r10
               	fldcw	(%r10)
               	xorq	%rax, %rax
               	movq	(%rsp), %r13
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r13, 0x8(%rsp)
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%rbx, %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	callq	<addr>
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rbx, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	cmpq	%rdx, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movq	%rax, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$0xfff, %rax            # imm = 0xFFF
               	cmpq	$0x37f, %rax            # imm = 0x37F
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
