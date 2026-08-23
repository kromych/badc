
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
               	movq	%rsp, %rsi
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
               	movl	$0x29, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x1, %edx
               	movl	%edx, 0xc(%rax)
               	movslq	%ecx, %rcx
               	movslq	%edx, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	%rsi, %rsp
               	leaq	-0x10(%rbp), %rsp
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<vla_and_guard>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rsp, %rdx
               	movl	$0x5, %eax
               	movl	%eax, -0x10(%rbp)
               	movl	$0xc, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rcx
               	subq	%r11, %rcx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rcx, %rsp
               	movslq	-0x10(%rbp), %rax
               	movl	%eax, (%rcx)
               	movslq	%eax, %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rsi
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdi
               	incq	%rdi
               	movl	%edi, (%rcx)
               	leaq	<rip>, %rcx
               	movslq	(%rsi), %rsi
               	movl	%esi, (%rcx)
               	movq	%rdx, %rsp
               	leaq	-0x20(%rbp), %rsp
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rbx
               	xorq	%rax, %rax
               	movl	%eax, (%rbx)
               	movl	$0x7, %ecx
               	movslq	(%rbx), %rcx
               	incq	%rcx
               	movl	%ecx, (%rbx)
               	leaq	<rip>, %rcx
               	movabsq	$-0x1, %rdx
               	movl	%edx, (%rcx)
               	movslq	(%rbx), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$-0x1, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	(%rbx), %rcx
               	incq	%rcx
               	movl	%ecx, (%rbx)
               	leaq	<rip>, %rcx
               	movl	%eax, (%rcx)
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, (%rbx)
               	movl	$0x1, %ecx
               	movl	%ecx, -0x28(%rbp)
               	movl	$0x2, %edx
               	movl	%edx, -0x18(%rbp)
               	movslq	%ecx, %rcx
               	movslq	%edx, %rdx
               	addq	%rdx, %rcx
               	addq	$0x6, %rcx
               	leaq	-0x18(%rbp), %rdx
               	movslq	(%rbx), %rsi
               	incq	%rsi
               	movl	%esi, (%rbx)
               	leaq	<rip>, %rsi
               	movslq	(%rdx), %rdi
               	movl	%edi, (%rsi)
               	leaq	-0x28(%rbp), %rsi
               	movslq	(%rbx), %rdi
               	incq	%rdi
               	movl	%edi, (%rbx)
               	leaq	<rip>, %rdi
               	movslq	(%rsi), %rsi
               	movl	%esi, (%rdi)
               	cmpl	$0x9, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	(%rbx), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	%eax, (%rbx)
               	movl	$0xb, %esi
               	movl	%esi, -0x18(%rbp)
               	movslq	%esi, %rcx
               	movslq	(%rbx), %rdi
               	incq	%rdi
               	movl	%edi, (%rbx)
               	leaq	<rip>, %rdi
               	movslq	(%rdx), %r8
               	movl	%r8d, (%rdi)
               	cmpl	$0xb, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	(%rbx), %rcx
               	cmpl	$0x1, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0xb, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	%eax, (%rbx)
               	movl	%eax, -0x18(%rbp)
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	-0x18(%rbp), %rax
               	addq	$0x3, %rax
               	movslq	(%rbx), %rcx
               	incq	%rcx
               	movl	%ecx, (%rbx)
               	leaq	<rip>, %rcx
               	movslq	(%rdx), %rdx
               	movl	%edx, (%rcx)
               	cmpl	$0x3, %eax
               	je	<addr>
               	movq	(%rsp), %rbx
               	movq	%rsi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	(%rbx), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, (%rbx)
               	movl	%eax, -0x28(%rbp)
               	movslq	%eax, %rdx
               	movl	$0x4, %ecx
               	movl	%ecx, -0x18(%rbp)
               	movslq	%ecx, %rcx
               	leaq	(%rcx,%rcx,4), %rcx
               	leaq	-0x18(%rbp), %rsi
               	movslq	(%rbx), %rdi
               	incq	%rdi
               	movl	%edi, (%rbx)
               	leaq	<rip>, %rdi
               	movslq	(%rsi), %rsi
               	movl	%esi, (%rdi)
               	addq	%rdx, %rcx
               	leaq	-0x28(%rbp), %rdx
               	movslq	(%rbx), %rsi
               	incq	%rsi
               	movl	%esi, (%rbx)
               	leaq	<rip>, %rsi
               	movslq	(%rdx), %rdx
               	movl	%edx, (%rsi)
               	cmpl	$0x14, %ecx
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	(%rbx), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x63, %eax
               	movl	%eax, -0x18(%rbp)
               	jmp	<addr>
               	jmp	<addr>
