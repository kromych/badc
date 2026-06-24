
two_d_array_param_indexing.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sum_short_row>:
               	movslq	%esi, %rsi
               	movq	%rsi, %rax
               	shlq	$0x2, %rax
               	addq	%rdi, %rax
               	movzwq	(%rax), %rcx
               	movzwq	0x2(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<sum_int_row>:
               	movslq	%esi, %rsi
               	imulq	$0xc, %rsi, %rax
               	addq	%rdi, %rax
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<sum_char_row>:
               	movslq	%esi, %rsi
               	movq	%rsi, %rax
               	shlq	$0x2, %rax
               	addq	%rdi, %rax
               	movsbq	(%rax), %rcx
               	movsbq	0x1(%rax), %rdx
               	addq	%rdx, %rcx
               	movsbq	0x2(%rax), %rdx
               	addq	%rdx, %rcx
               	movsbq	0x3(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x4c0, %rsp            # imm = 0x4C0
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x100, %rax            # imm = 0x100
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	-0x400(%rbp), %rax
               	movslq	%ecx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rax
               	xorq	%rdx, %rdx
               	movw	%dx, (%rax)
               	leaq	-0x400(%rbp), %rax
               	movslq	%ecx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rax
               	movw	%dx, 0x2(%rax)
               	jmp	<addr>
               	leaq	-0x400(%rbp), %rax
               	movl	$0x1234, %ecx           # imm = 0x1234
               	movw	%cx, 0x14(%rax)
               	leaq	-0x400(%rbp), %rax
               	movl	$0x10, %ecx
               	movw	%cx, 0x16(%rax)
               	leaq	-0x400(%rbp), %rax
               	movl	$0x5, %ecx
               	movslq	%ecx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movzwq	(%rax), %rcx
               	movzwq	0x2(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x1244, %rax           # imm = 0x1244
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0xa, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	leaq	-0x480(%rbp), %rax
               	movl	$0x7, %ecx
               	movslq	%ecx, %rcx
               	imulq	$0xc, %rcx, %rcx
               	addq	%rcx, %rax
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x837, %rax            # imm = 0x837
               	je	<addr>
               	jmp	<addr>
               	movslq	%edx, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rax
               	movq	%rax, %rdx
               	incq	%rdx
               	jmp	<addr>
               	leaq	-0x480(%rbp), %rax
               	movslq	%ecx, %rsi
               	imulq	$0xc, %rsi, %rdi
               	addq	%rdi, %rax
               	movslq	%edx, %rdi
               	imulq	$0x64, %rsi, %rsi
               	addq	%rdi, %rsi
               	movl	%esi, (%rax,%rdi,4)
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x2, %eax
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	leaq	-0x4a8(%rbp), %rax
               	movl	$0x3, %ecx
               	movslq	%ecx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movsbq	(%rax), %rcx
               	movsbq	0x1(%rax), %rdx
               	addq	%rdx, %rcx
               	movsbq	0x2(%rax), %rdx
               	addq	%rdx, %rcx
               	movsbq	0x3(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x116, %rax            # imm = 0x116
               	je	<addr>
               	jmp	<addr>
               	movslq	%edx, %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rax
               	movq	%rax, %rdx
               	incq	%rdx
               	jmp	<addr>
               	leaq	-0x4a8(%rbp), %rax
               	movslq	%ecx, %rsi
               	movq	%rsi, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %rax
               	movslq	%edx, %rdi
               	addq	%rdi, %rax
               	addq	$0x41, %rsi
               	addq	%rdi, %rsi
               	movslq	%esi, %rdi
               	movb	%dil, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x3, %eax
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
