
stmt_expr_scope_exit_value.x64:	file format elf64-x86-64

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

<vla_value>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rsp, %rcx
               	movl	$0x10, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rax, %rsp
               	movl	$0x29, (%rax)
               	movl	$0x1, 0xc(%rax)
               	movq	%rcx, %rsp
               	movl	$0x2a, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq

<vla_and_guard>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x5, -0x10(%rbp)
               	movq	%rsp, %rcx
               	movl	$0xc, %edx
               	movq	%rdx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rdx
               	subq	%r11, %rdx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rdx, %rsp
               	movl	$0x5, (%rdx)
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %edx
               	incq	%rdx
               	movl	%edx, (%rax)
               	leaq	<rip>, %rax      # <addr>
               	movl	-0x10(%rbp), %edx
               	movl	%edx, (%rax)
               	movq	%rcx, %rsp
               	movl	$0x7, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rax      # <addr>
               	movl	$0x0, (%rax)
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rcx      # <addr>
               	movl	$0xffffffff, (%rcx)     # imm = 0xFFFFFFFF
               	movl	(%rax), %esi
               	cmpl	$0x1, %esi
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	(%rcx), %esi
               	cmpl	$-0x1, %esi
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	(%rax), %esi
               	incq	%rsi
               	movl	%esi, (%rax)
               	movl	$0x0, (%rcx)
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	$0x0, (%rax)
               	movl	$0x1, -0x10(%rbp)
               	movl	$0x2, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rsi
               	movl	(%rax), %edx
               	incq	%rdx
               	movl	%edx, (%rax)
               	leaq	<rip>, %rdx      # <addr>
               	movl	(%rsi), %edi
               	movl	%edi, (%rdx)
               	movl	(%rax), %edi
               	incq	%rdi
               	movl	%edi, (%rax)
               	movl	-0x10(%rbp), %edi
               	movl	%edi, (%rdx)
               	movl	(%rax), %edx
               	cmpl	$0x2, %edx
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x0, (%rax)
               	movl	$0xb, -0x8(%rbp)
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rdx      # <addr>
               	movl	(%rsi), %ecx
               	movl	%ecx, (%rdx)
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	(%rdx), %ecx
               	cmpl	$0xb, %ecx
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	$0x0, (%rax)
               	movl	$0x0, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rsi
               	movl	(%rax), %edi
               	incq	%rdi
               	movl	%edi, (%rax)
               	movl	(%rsi), %edi
               	movl	%edi, (%rdx)
               	movl	(%rax), %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	$0x0, (%rax)
               	movl	$0x0, -0x10(%rbp)
               	movl	$0x4, -0x8(%rbp)
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rcx      # <addr>
               	movl	(%rsi), %edx
               	movl	%edx, (%rcx)
               	movl	(%rax), %edx
               	incq	%rdx
               	movl	%edx, (%rax)
               	movl	-0x10(%rbp), %edx
               	movl	%edx, (%rcx)
               	movl	(%rax), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
