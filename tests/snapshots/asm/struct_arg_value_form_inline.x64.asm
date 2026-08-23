
struct_arg_value_form_inline.x64:	file format elf64-x86-64

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

<take_kuid>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	movl	%eax, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<take_triple>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rcx
               	movzbq	0x1(%rax), %rdx
               	shlq	$0x8, %rdx
               	movl	%edx, %edx
               	orq	%rdx, %rcx
               	movzbq	0x2(%rax), %rax
               	shlq	$0x10, %rax
               	movl	%eax, %eax
               	orq	%rcx, %rax
               	movl	%eax, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<take_pair>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	0x4(%rax), %ecx
               	shlq	$0x20, %rcx
               	movl	(%rax), %eax
               	orq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<take_wide>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%ecx, %edx
               	movl	%edx, %edx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x4, %ecx
               	jb	<addr>
               	leaq	<rip>, %rcx
               	xorq	%rax, %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rcx
               	movl	(%rcx), %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	retq
               	movl	$0x3, %eax
               	retq
