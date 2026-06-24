
typedef_array_param_decay.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<copy>:
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x10, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	shlq	$0x3, %rax
               	leaq	(%rdi,%rax), %rdx
               	addq	%rsi, %rax
               	movq	(%rax), %rax
               	movq	%rax, (%rdx)
               	jmp	<addr>
               	xorq	%rax, %rax
               	retq

<sum>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movslq	%eax, %rdx
               	cmpq	$0x10, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%eax, %rax
               	incq	%rax
               	jmp	<addr>
               	movslq	%eax, %rdx
               	movq	(%rdi,%rdx,8), %rdx
               	addq	%rdx, %rcx
               	jmp	<addr>
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x120, %rsp            # imm = 0x120
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x10, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	incq	%rsi
               	movq	%rsi, (%rax,%rdx,8)
               	jmp	<addr>
               	leaq	-0x100(%rbp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	callq	<addr>
               	movl	$0x110, %ecx            # imm = 0x110
               	xorq	%rdx, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x1, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x100(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x100(%rbp), %rax
               	movq	0x78(%rax), %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
