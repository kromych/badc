
overaligned_vla.x64:	file format elf64-x86-64

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

<touch>:
               	movb	%sil, (%rdi)
               	movl	<rip>, %eax # <addr>
               	addq	%rsi, %rax
               	movl	%eax, <rip> # <addr>
               	retq

<element_aligned>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r15d, %r15d
               	movl	$0x1, %ebx
               	jmp	<addr>
               	orq	%rdx, %r15
               	movq	-0x20(%rbp), %r10
               	movq	%r10, %rsp
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jg	<addr>
               	movq	%rsp, %r10
               	movq	%r10, -0x20(%rbp)
               	leaq	(%rbx,%rbx,2), %rax
               	incq	%rax
               	movslq	%eax, %r12
               	movq	%r12, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r13
               	subq	%r11, %r13
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%r13, %rsp
               	movl	$0x5a, %esi
               	movq	%r13, %rdi
               	movq	%r12, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x3(%rbx), %rax
               	movq	%rax, %r10
               	shlq	$0x6, %r10
               	movq	%r10, -0x18(%rbp)
               	movq	%r10, %rax
               	addq	$0x30, %rax
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
               	leaq	0x3f(%rax), %r14
               	andq	$-0x40, %r14
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	movq	-0x18(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movl	$0x60, %edx
               	movl	$0x70, %eax
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
               	leaq	0x1f(%rax), %rcx
               	andq	$-0x20, %rcx
               	leaq	0x1(%rbx), %rsi
               	movq	%rcx, -0x28(%rbp)
               	movq	%rcx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0x28(%rbp), %rcx
               	testb	$0x3f, %r14b
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	0x40(%r14), %rax
               	andq	$0x3f, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%r15, %rdx
               	orq	%rax, %rdx
               	testb	$0x1f, %cl
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	0x3(%rbx), %rax
               	shlq	$0x6, %rax
               	movq	%rax, %r10
               	movq	-0x18(%rbp), %rax
               	cmpl	%r10d, %eax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rdx
               	leaq	0x3(%rbx), %rax
               	decq	%rax
               	shlq	$0x6, %rax
               	addq	%r14, %rax
               	movsbq	0x3f(%rax), %rax
               	cmpl	%ebx, %eax
               	movl	$0x1, %r15d
               	jne	<addr>
               	xorl	%eax, %eax
               	cmpq	%r12, %rax
               	jae	<addr>
               	movsbq	(%r13,%rax), %rcx
               	cmpl	$0x5a, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpq	%r12, %rax
               	jb	<addr>
               	movl	$0x1, %eax
               	testl	%eax, %eax
               	sete	%r15b
               	movzbq	%r15b, %r15
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	%r15, %rax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<declaration_aligned>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r15d, %r15d
               	movl	$0x1, %r12d
               	jmp	<addr>
               	orq	%rdx, %r15
               	movq	-0x20(%rbp), %r10
               	movq	%r10, %rsp
               	incq	%r12
               	cmpl	$0x4, %r12d
               	jg	<addr>
               	movq	%rsp, %r10
               	movq	%r10, -0x20(%rbp)
               	leaq	(%r12,%r12,4), %rax
               	incq	%rax
               	movslq	%eax, %rbx
               	movq	%rbx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r13
               	subq	%r11, %r13
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%r13, %rsp
               	movl	$0x5a, %esi
               	movq	%r13, %rdi
               	movq	%rbx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x3(%r12), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	%r10, %rax
               	addq	$0x70, %rax
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
               	leaq	0x7f(%rax), %r14
               	andq	$-0x80, %r14
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movq	-0x18(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%r14, %rax
               	andq	$0x7f, %rax
               	movl	$0x1, %ecx
               	leaq	0x3(%r12), %rdx
               	movq	%rdx, %r10
               	movq	-0x18(%rbp), %rdx
               	cmpl	%r10d, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testl	%eax, %eax
               	cmoveq	%rdx, %rcx
               	movq	%r15, %rdx
               	orq	%rcx, %rdx
               	leaq	0x3(%r12), %rax
               	decq	%rax
               	movsbq	(%r14,%rax), %rax
               	cmpl	%r12d, %eax
               	movl	$0x1, %r15d
               	jne	<addr>
               	xorl	%eax, %eax
               	cmpq	%rbx, %rax
               	jae	<addr>
               	movsbq	(%r13,%rax), %rcx
               	cmpl	$0x5a, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpq	%rbx, %rax
               	jb	<addr>
               	movl	$0x1, %eax
               	testl	%eax, %eax
               	sete	%r15b
               	movzbq	%r15b, %r15
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	%r15, %rax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x3, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
