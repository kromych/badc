
loop_idiom_version.x64:	file format elf64-x86-64

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

<indexed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%edx, %rdx
               	xorl	%eax, %eax
               	testl	%edx, %edx
               	jle	<addr>
               	movq	%rdi, %rcx
               	subq	%rsi, %rcx
               	cmpq	%rdx, %rcx
               	jb	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	retq
               	movzbq	(%rsi,%rax), %rcx
               	movb	%cl, (%rdi,%rax)
               	incq	%rax
               	cmpl	%edx, %eax
               	jge	<addr>
               	jmp	<addr>

<into_array>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%esi, %rsi
               	xorl	%eax, %eax
               	testl	%esi, %esi
               	jle	<addr>
               	leaq	<rip>, %rcx
               	subq	%rdi, %rcx
               	cmpq	%rsi, %rcx
               	jb	<addr>
               	leaq	<rip>, %rax
               	movq	%rsi, %rdx
               	movq	%rdi, %rsi
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movzbq	(%rdi,%rax), %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	%esi, %eax
               	jge	<addr>
               	jmp	<addr>

<out_of_array>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%esi, %rsi
               	xorl	%eax, %eax
               	testl	%esi, %esi
               	jle	<addr>
               	leaq	<rip>, %rcx
               	movq	%rdi, %rdx
               	subq	%rcx, %rdx
               	cmpq	%rsi, %rdx
               	jb	<addr>
               	leaq	<rip>, %rax
               	movq	%rsi, %rdx
               	movq	%rax, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movzbq	(%rcx,%rax), %rcx
               	movb	%cl, (%rdi,%rax)
               	incq	%rax
               	cmpl	%esi, %eax
               	jge	<addr>
               	jmp	<addr>

<blocked3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movq	%rdx, %rbx
               	movq	%rsi, %r13
               	cmpl	$0x2, %ebx
               	jbe	<addr>
               	movq	%r12, %rdi
               	subq	%r13, %rdi
               	movl	%ebx, %eax
               	movl	$0xaaaaaaab, %ecx       # imm = 0xAAAAAAAB
               	imulq	%rax, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x21, %rdx
               	leaq	(%rdx,%rdx,2), %rsi
               	cmpq	%rsi, %rdi
               	jb	<addr>
               	movq	%r12, %rdi
               	movq	%rsi, %rdx
               	movq	%r13, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	%ebx, %ecx
               	movl	$0xaaaaaaab, %eax       # imm = 0xAAAAAAAB
               	imulq	%rcx, %rax
               	shrq	$0x21, %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	%rax, %r12
               	addq	%rax, %r13
               	movq	%rcx, %rbx
               	subq	%rax, %rbx
               	movl	%ebx, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	0x1(%r12), %rdi
               	leaq	0x1(%r13), %rsi
               	movzbq	(%r13), %rax
               	movb	%al, (%r12)
               	decq	%rbx
               	movq	%rdi, %r12
               	movq	%rsi, %r13
               	movl	%ebx, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movzbq	(%r13), %rax
               	movb	%al, (%r12)
               	movzbq	0x1(%r13), %rax
               	movb	%al, 0x1(%r12)
               	movzbq	0x2(%r13), %rax
               	movb	%al, 0x2(%r12)
               	addq	$0x3, %r12
               	addq	$0x3, %r13
               	subq	$0x3, %rbx
               	cmpl	$0x2, %ebx
               	ja	<addr>
               	jmp	<addr>

<walk1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movq	%rdx, %rbx
               	movq	%rsi, %r13
               	testl	%ebx, %ebx
               	jbe	<addr>
               	movq	%r12, %rax
               	subq	%r13, %rax
               	movl	%ebx, %edx
               	cmpq	%rdx, %rax
               	jb	<addr>
               	movq	%r12, %rdi
               	movq	%r13, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movzbq	(%r13), %rax
               	movb	%al, (%r12)
               	incq	%r12
               	incq	%r13
               	decq	%rbx
               	testl	%ebx, %ebx
               	jbe	<addr>
               	jmp	<addr>

<words4>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rdx, %r13
               	movq	%rsi, %r12
               	cmpl	$0x4, %r13d
               	jb	<addr>
               	movq	%rbx, %rdi
               	subq	%r12, %rdi
               	movl	%r13d, %eax
               	movq	%rax, %rcx
               	andq	$0x3, %rcx
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x2, %rsi
               	cmpq	%rsi, %rdi
               	jb	<addr>
               	movq	%rbx, %rdi
               	movq	%rsi, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	(%r12), %eax
               	movl	%eax, (%rbx)
               	movl	0x4(%r12), %eax
               	movl	%eax, 0x4(%rbx)
               	movl	0x8(%r12), %eax
               	movl	%eax, 0x8(%rbx)
               	movl	0xc(%r12), %eax
               	movl	%eax, 0xc(%rbx)
               	addq	$0x10, %rbx
               	addq	$0x10, %r12
               	subq	$0x4, %r13
               	cmpl	$0x4, %r13d
               	jb	<addr>
               	jmp	<addr>

<same>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movslq	%esi, %r13
               	movq	%rcx, %rbx
               	movslq	%edx, %r14
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	cmpl	$0x40, %eax
               	jge	<addr>
               	leaq	0x1(%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	movb	%cl, (%rsi,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	<rip>, %r12
               	leaq	(%r12,%r13), %rax
               	leaq	(%r12,%r14), %rsi
               	movl	%ebx, %edx
               	movq	%rdi, %rcx
               	movq	%rax, %rdi
               	callq	*%rcx
               	leaq	<rip>, %rdi
               	leaq	(%rdi,%r13), %rax
               	leaq	(%rdi,%r14), %rcx
               	movl	$0x0, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rdx
               	movslq	-0x8(%rbp), %rsi
               	movzbq	(%rcx,%rsi), %rsi
               	movb	%sil, (%rax,%rdx)
               	movslq	-0x8(%rbp), %rdx
               	incq	%rdx
               	movl	%edx, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rdx
               	cmpl	%ebx, %edx
               	jl	<addr>
               	movl	$0x40, %edx
               	movq	%rdi, %rsi
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r13d, %r13d
               	cmpl	$0x8, %r13d
               	jge	<addr>
               	xorl	%r12d, %r12d
               	cmpl	$0x8, %r12d
               	jge	<addr>
               	xorl	%ebx, %ebx
               	cmpl	$0x14, %ebx
               	ja	<addr>
               	leaq	-<rip>, %rdi      # <addr>
               	movq	%r13, %rsi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-<rip>, %rdi      # <addr>
               	movq	%r13, %rsi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	incq	%rbx
               	cmpl	$0x14, %ebx
               	jbe	<addr>
               	incq	%r12
               	cmpl	$0x8, %r12d
               	jl	<addr>
               	incq	%r13
               	cmpl	$0x8, %r13d
               	jl	<addr>
               	xorl	%r13d, %r13d
               	cmpl	$0x8, %r13d
               	jge	<addr>
               	xorl	%r12d, %r12d
               	cmpl	$0x8, %r12d
               	jge	<addr>
               	xorl	%ebx, %ebx
               	cmpl	$0x14, %ebx
               	jg	<addr>
               	xorl	%eax, %eax
               	cmpl	$0x40, %eax
               	jge	<addr>
               	leaq	<rip>, %rdx
               	leaq	0x1(%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	leaq	<rip>, %rdx
               	movb	%cl, (%rdx,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	<rip>, %r14
               	leaq	(%r14,%r13), %rdi
               	leaq	(%r14,%r12), %rsi
               	movq	%rbx, %rdx
               	callq	<addr>
               	leaq	<rip>, %rdi
               	leaq	(%rdi,%r13), %rax
               	leaq	(%rdi,%r12), %rcx
               	movl	$0x0, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rdx
               	movslq	-0x8(%rbp), %rsi
               	movzbq	(%rcx,%rsi), %rsi
               	movb	%sil, (%rax,%rdx)
               	movslq	-0x8(%rbp), %rdx
               	incq	%rdx
               	movl	%edx, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rdx
               	cmpl	%ebx, %edx
               	jl	<addr>
               	movl	$0x40, %edx
               	movq	%rdi, %rsi
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x14, %ebx
               	jle	<addr>
               	incq	%r12
               	cmpl	$0x8, %r12d
               	jl	<addr>
               	incq	%r13
               	cmpl	$0x8, %r13d
               	jl	<addr>
               	xorl	%eax, %eax
               	cmpl	$0x40, %eax
               	jge	<addr>
               	leaq	<rip>, %rdx
               	leaq	0x1(%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	leaq	<rip>, %rdx
               	movb	%cl, (%rdx,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	<rip>, %rbx
               	leaq	0x8(%rbx), %rsi
               	movq	$-0x3, %rdx
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x40, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	xorl	%r12d, %r12d
               	cmpl	$0x8, %r12d
               	jge	<addr>
               	xorl	%ebx, %ebx
               	cmpl	$0x14, %ebx
               	jg	<addr>
               	xorl	%eax, %eax
               	cmpl	$0x40, %eax
               	jge	<addr>
               	leaq	<rip>, %rdx
               	leaq	0x1(%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	leaq	<rip>, %rdx
               	movb	%cl, (%rdx,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	<rip>, %r13
               	leaq	(%r13,%r12), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	<rip>, %rax
               	leaq	(%rax,%r12), %rcx
               	movl	$0x0, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rdx
               	movslq	-0x8(%rbp), %rsi
               	movzbq	(%rcx,%rsi), %rsi
               	movb	%sil, (%rax,%rdx)
               	movslq	-0x8(%rbp), %rdx
               	incq	%rdx
               	movl	%edx, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rdx
               	cmpl	%ebx, %edx
               	jl	<addr>
               	movl	$0x40, %edx
               	movq	%r13, %rdi
               	movq	%rax, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	cmpl	$0x40, %eax
               	jge	<addr>
               	leaq	<rip>, %rdx
               	leaq	0x1(%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	leaq	<rip>, %rdx
               	movb	%cl, (%rdx,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	<rip>, %r13
               	leaq	(%r13,%r12), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	<rip>, %rax
               	leaq	(%rax,%r12), %rcx
               	movl	$0x0, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rdx
               	movslq	-0x8(%rbp), %rsi
               	movzbq	(%rax,%rsi), %rsi
               	movb	%sil, (%rcx,%rdx)
               	movslq	-0x8(%rbp), %rdx
               	incq	%rdx
               	movl	%edx, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rdx
               	cmpl	%ebx, %edx
               	jl	<addr>
               	movl	$0x40, %edx
               	movq	%r13, %rdi
               	movq	%rax, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x14, %ebx
               	jle	<addr>
               	incq	%r12
               	cmpl	$0x8, %r12d
               	jl	<addr>
               	leaq	<rip>, %rbx
               	leaq	0x20(%rbx), %r12
               	xorl	%eax, %eax
               	cmpl	$0x40, %eax
               	jge	<addr>
               	leaq	<rip>, %rdx
               	leaq	0x1(%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	leaq	<rip>, %rdx
               	movb	%cl, (%rdx,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	movq	%rbx, %rax
               	subq	%r12, %rax
               	cmpq	$0x9, %rax
               	jb	<addr>
               	movl	$0x9, %edx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x9(%rbx), %rdx
               	leaq	0x9(%r12), %rax
               	movl	$0x2, %ecx
               	leaq	<rip>, %rcx
               	addq	$0x9, %rcx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x29, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	leaq	0x20(%rax), %rsi
               	movl	$0x9, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x9(%rax), %rcx
               	leaq	<rip>, %rax
               	movzbq	0x9(%rax), %rax
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	$0x1020304, (%rax)      # imm = 0x1020304
               	leaq	<rip>, %rdx
               	movl	$0x1020304, (%rdx)      # imm = 0x1020304
               	leaq	<rip>, %rax
               	movl	$0x2040608, 0x4(%rax)   # imm = 0x2040608
               	leaq	<rip>, %rdx
               	movl	$0x2040608, 0x4(%rdx)   # imm = 0x2040608
               	leaq	<rip>, %rax
               	movl	$0x306090c, 0x8(%rax)   # imm = 0x306090C
               	leaq	<rip>, %rdx
               	movl	$0x306090c, 0x8(%rdx)   # imm = 0x306090C
               	leaq	<rip>, %rax
               	movl	$0x4080c10, 0xc(%rax)   # imm = 0x4080C10
               	leaq	<rip>, %rdx
               	movl	$0x4080c10, 0xc(%rdx)   # imm = 0x4080C10
               	leaq	<rip>, %rax
               	movl	$0x50a0f14, 0x10(%rax)  # imm = 0x50A0F14
               	leaq	<rip>, %rdx
               	movl	$0x50a0f14, 0x10(%rdx)  # imm = 0x50A0F14
               	leaq	<rip>, %rax
               	movl	$0x60c1218, 0x14(%rax)  # imm = 0x60C1218
               	leaq	<rip>, %rdx
               	movl	$0x60c1218, 0x14(%rdx)  # imm = 0x60C1218
               	leaq	<rip>, %rax
               	movl	$0x70e151c, 0x18(%rax)  # imm = 0x70E151C
               	leaq	<rip>, %rdx
               	movl	$0x70e151c, 0x18(%rdx)  # imm = 0x70E151C
               	leaq	<rip>, %rax
               	movl	$0x8101820, 0x1c(%rax)  # imm = 0x8101820
               	leaq	<rip>, %rdx
               	movl	$0x8101820, 0x1c(%rdx)  # imm = 0x8101820
               	leaq	<rip>, %rax
               	movl	$0x9121b24, 0x20(%rax)  # imm = 0x9121B24
               	leaq	<rip>, %rdx
               	movl	$0x9121b24, 0x20(%rdx)  # imm = 0x9121B24
               	leaq	<rip>, %rax
               	movl	$0xa141e28, 0x24(%rax)  # imm = 0xA141E28
               	leaq	<rip>, %rdx
               	movl	$0xa141e28, 0x24(%rdx)  # imm = 0xA141E28
               	leaq	<rip>, %rax
               	movl	$0xb16212c, 0x28(%rax)  # imm = 0xB16212C
               	leaq	<rip>, %rdx
               	movl	$0xb16212c, 0x28(%rdx)  # imm = 0xB16212C
               	leaq	<rip>, %rax
               	movl	$0xc182430, 0x2c(%rax)  # imm = 0xC182430
               	leaq	<rip>, %rdx
               	movl	$0xc182430, 0x2c(%rdx)  # imm = 0xC182430
               	leaq	<rip>, %rax
               	movl	$0xd1a2734, 0x30(%rax)  # imm = 0xD1A2734
               	leaq	<rip>, %rdx
               	movl	$0xd1a2734, 0x30(%rdx)  # imm = 0xD1A2734
               	leaq	<rip>, %rax
               	movl	$0xe1c2a38, 0x34(%rax)  # imm = 0xE1C2A38
               	leaq	<rip>, %rdx
               	movl	$0xe1c2a38, 0x34(%rdx)  # imm = 0xE1C2A38
               	leaq	<rip>, %rax
               	movl	$0xf1e2d3c, 0x38(%rax)  # imm = 0xF1E2D3C
               	leaq	<rip>, %rdx
               	movl	$0xf1e2d3c, 0x38(%rdx)  # imm = 0xF1E2D3C
               	leaq	<rip>, %rax
               	movl	$0x10203040, 0x3c(%rax) # imm = 0x10203040
               	leaq	<rip>, %rdx
               	movl	$0x10203040, 0x3c(%rdx) # imm = 0x10203040
               	leaq	<rip>, %rbx
               	movl	$0x20, %r12d
               	leaq	0x20(%rbx), %rsi
               	movl	$0x8, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	<rip>, %rax
               	leaq	0x20(%rax), %rsi
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r12
               	pushq	%rax
               	movq	(%r12), %rax
               	movq	%rax, (%rbx)
               	movq	0x8(%r12), %rax
               	movq	%rax, 0x8(%rbx)
               	movq	0x10(%r12), %rax
               	movq	%rax, 0x10(%rbx)
               	movq	0x18(%r12), %rax
               	movq	%rax, 0x18(%rbx)
               	movq	0x20(%r12), %rax
               	movq	%rax, 0x20(%rbx)
               	movq	0x28(%r12), %rax
               	movq	%rax, 0x28(%rbx)
               	movq	0x30(%r12), %rax
               	movq	%rax, 0x30(%rbx)
               	movq	0x38(%r12), %rax
               	movq	%rax, 0x38(%rbx)
               	popq	%rax
               	leaq	0x20(%rbx), %rsi
               	movl	$0x3, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	$0x40, %edx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movzbq	(%r12), %rax
               	movb	%al, (%rbx)
               	movzbq	0x1(%r12), %rax
               	movb	%al, 0x1(%rbx)
               	movzbq	0x2(%r12), %rax
               	movb	%al, 0x2(%rbx)
               	leaq	0x3(%rbx), %rax
               	leaq	0x3(%r12), %rcx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	addq	$0x3, %rax
               	addq	$0x3, %rcx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	leaq	0x3(%rax), %rdx
               	leaq	0x3(%rcx), %rax
               	movl	$0x2, %ecx
               	jmp	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
