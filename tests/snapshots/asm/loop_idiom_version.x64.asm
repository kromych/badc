
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
               	movq	%rcx, %rdx
               	subq	%rdi, %rdx
               	cmpq	%rsi, %rdx
               	jb	<addr>
               	movq	%rsi, %rdx
               	movq	%rdi, %rsi
               	movq	%rcx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	retq
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
               	movq	%rsi, %rdx
               	movq	%rcx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	retq
               	movzbq	(%rcx,%rax), %rdx
               	movb	%dl, (%rdi,%rax)
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
               	movq	%rdi, %rbx
               	movq	%rdx, %r13
               	movq	%rsi, %r12
               	cmpl	$0x2, %r13d
               	jbe	<addr>
               	movq	%rbx, %rax
               	subq	%r12, %rax
               	movl	%r13d, %ecx
               	movl	$0xaaaaaaab, %r11d      # imm = 0xAAAAAAAB
               	imulq	%r11, %rcx
               	shrq	$0x21, %rcx
               	leaq	(%rcx,%rcx,2), %rdx
               	cmpq	%rdx, %rax
               	jb	<addr>
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	%r13d, %ecx
               	movl	$0xaaaaaaab, %eax       # imm = 0xAAAAAAAB
               	imulq	%rcx, %rax
               	shrq	$0x21, %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	%rax, %rbx
               	addq	%rax, %r12
               	movq	%rcx, %r13
               	subq	%rax, %r13
               	testl	%r13d, %r13d
               	je	<addr>
               	leaq	0x1(%rbx), %rdi
               	leaq	0x1(%r12), %rsi
               	movzbq	(%r12), %rax
               	movb	%al, (%rbx)
               	decq	%r13
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	testl	%r13d, %r13d
               	jne	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movzbq	(%r12), %rax
               	movb	%al, (%rbx)
               	movzbq	0x1(%r12), %rax
               	movb	%al, 0x1(%rbx)
               	movzbq	0x2(%r12), %rax
               	movb	%al, 0x2(%rbx)
               	addq	$0x3, %rbx
               	addq	$0x3, %r12
               	subq	$0x3, %r13
               	cmpl	$0x2, %r13d
               	jbe	<addr>
               	jmp	<addr>

<walk1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	testl	%edx, %edx
               	jbe	<addr>
               	movq	%rdi, %rcx
               	subq	%rsi, %rcx
               	movl	%edx, %eax
               	cmpq	%rax, %rcx
               	jb	<addr>
               	movq	%rax, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	retq
               	movzbq	(%rsi), %rax
               	movb	%al, (%rdi)
               	incq	%rdi
               	incq	%rsi
               	decq	%rdx
               	testl	%edx, %edx
               	jbe	<addr>
               	jmp	<addr>

<words4>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	cmpl	$0x4, %edx
               	jb	<addr>
               	movq	%rdi, %rcx
               	subq	%rsi, %rcx
               	movl	%edx, %eax
               	movq	%rax, %r8
               	andq	$0x3, %r8
               	subq	%r8, %rax
               	shlq	$0x2, %rax
               	cmpq	%rax, %rcx
               	jb	<addr>
               	movq	%rax, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	retq
               	movl	(%rsi), %eax
               	movl	%eax, (%rdi)
               	movl	0x4(%rsi), %eax
               	movl	%eax, 0x4(%rdi)
               	movl	0x8(%rsi), %eax
               	movl	%eax, 0x8(%rdi)
               	movl	0xc(%rsi), %eax
               	movl	%eax, 0xc(%rdi)
               	addq	$0x10, %rdi
               	addq	$0x10, %rsi
               	subq	$0x4, %rdx
               	cmpl	$0x4, %edx
               	jb	<addr>
               	jmp	<addr>

<same>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movslq	%esi, %r12
               	movq	%rcx, %rbx
               	movslq	%edx, %r13
               	leaq	<rip>, %rcx
               	leaq	<rip>, %r9
               	xorl	%eax, %eax
               	leaq	0x1(%rax), %r8
               	movb	%r8b, (%rcx,%rax)
               	movb	%r8b, (%r9,%rax)
               	movq	%r8, %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	leaq	(%rax,%r12), %rcx
               	leaq	(%rax,%r13), %rsi
               	movl	%ebx, %edx
               	movq	%rdi, %rax
               	movq	%rcx, %rdi
               	callq	*%rax
               	leaq	<rip>, %rcx
               	leaq	(%rcx,%r12), %rax
               	addq	%r13, %rcx
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
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r13d, %r13d
               	xorl	%r12d, %r12d
               	xorl	%ebx, %ebx
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
               	xorl	%r12d, %r12d
               	xorl	%ebx, %ebx
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx
               	leaq	0x1(%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	leaq	<rip>, %rdx
               	movb	%cl, (%rdx,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	leaq	(%rax,%r13), %rdi
               	leaq	(%rax,%r12), %rsi
               	movq	%rbx, %rdx
               	callq	<addr>
               	leaq	<rip>, %rcx
               	leaq	(%rcx,%r13), %rax
               	addq	%r12, %rcx
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
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x40, %edx
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
               	leaq	<rip>, %rdx
               	leaq	0x1(%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	leaq	<rip>, %rdx
               	movb	%cl, (%rdx,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	<rip>, %rdi
               	leaq	0x8(%rdi), %rsi
               	movq	$-0x3, %rdx
               	callq	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%r12d, %r12d
               	xorl	%ebx, %ebx
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx
               	leaq	0x1(%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	leaq	<rip>, %rdx
               	movb	%cl, (%rdx,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	leaq	(%rax,%r12), %rdi
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
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx
               	leaq	0x1(%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	leaq	<rip>, %rdx
               	movb	%cl, (%rdx,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	leaq	(%rax,%r12), %rdi
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
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x40, %edx
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
               	leaq	0x1(%rax), %rcx
               	movb	%cl, (%rbx,%rax)
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
               	leaq	<rip>, %rdi
               	leaq	0x9(%rdi), %rcx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	leaq	0x29(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	leaq	0x20(%rax), %rsi
               	movl	$0x9, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x9(%rax), %rax
               	leaq	<rip>, %rcx
               	movzbq	0x9(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	$0x1020304, (%rax)      # imm = 0x1020304
               	leaq	<rip>, %rcx
               	movl	$0x1020304, (%rcx)      # imm = 0x1020304
               	movl	$0x2040608, 0x4(%rax)   # imm = 0x2040608
               	movl	$0x2040608, 0x4(%rcx)   # imm = 0x2040608
               	movl	$0x306090c, 0x8(%rax)   # imm = 0x306090C
               	movl	$0x306090c, 0x8(%rcx)   # imm = 0x306090C
               	movl	$0x4080c10, 0xc(%rax)   # imm = 0x4080C10
               	leaq	<rip>, %rax
               	movl	$0x4080c10, 0xc(%rax)   # imm = 0x4080C10
               	leaq	<rip>, %rcx
               	movl	$0x50a0f14, 0x10(%rcx)  # imm = 0x50A0F14
               	movl	$0x50a0f14, 0x10(%rax)  # imm = 0x50A0F14
               	movl	$0x60c1218, 0x14(%rcx)  # imm = 0x60C1218
               	movl	$0x60c1218, 0x14(%rax)  # imm = 0x60C1218
               	movl	$0x70e151c, 0x18(%rcx)  # imm = 0x70E151C
               	movl	$0x70e151c, 0x18(%rax)  # imm = 0x70E151C
               	leaq	<rip>, %rax
               	movl	$0x8101820, 0x1c(%rax)  # imm = 0x8101820
               	leaq	<rip>, %rcx
               	movl	$0x8101820, 0x1c(%rcx)  # imm = 0x8101820
               	movl	$0x9121b24, 0x20(%rax)  # imm = 0x9121B24
               	movl	$0x9121b24, 0x20(%rcx)  # imm = 0x9121B24
               	movl	$0xa141e28, 0x24(%rax)  # imm = 0xA141E28
               	movl	$0xa141e28, 0x24(%rcx)  # imm = 0xA141E28
               	movl	$0xb16212c, 0x28(%rax)  # imm = 0xB16212C
               	leaq	<rip>, %rax
               	movl	$0xb16212c, 0x28(%rax)  # imm = 0xB16212C
               	leaq	<rip>, %rcx
               	movl	$0xc182430, 0x2c(%rcx)  # imm = 0xC182430
               	movl	$0xc182430, 0x2c(%rax)  # imm = 0xC182430
               	movl	$0xd1a2734, 0x30(%rcx)  # imm = 0xD1A2734
               	movl	$0xd1a2734, 0x30(%rax)  # imm = 0xD1A2734
               	movl	$0xe1c2a38, 0x34(%rcx)  # imm = 0xE1C2A38
               	movl	$0xe1c2a38, 0x34(%rax)  # imm = 0xE1C2A38
               	leaq	<rip>, %rdi
               	movl	$0xf1e2d3c, 0x38(%rdi)  # imm = 0xF1E2D3C
               	leaq	<rip>, %rcx
               	movl	$0xf1e2d3c, 0x38(%rcx)  # imm = 0xF1E2D3C
               	movl	$0x10203040, 0x3c(%rdi) # imm = 0x10203040
               	movl	$0x10203040, 0x3c(%rcx) # imm = 0x10203040
               	leaq	0x20(%rdi), %rsi
               	movl	$0x8, %edx
               	callq	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movl	$0x20, %edx
               	leaq	0x20(%rax), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdi)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdi)
               	movq	0x20(%rax), %rcx
               	movq	%rcx, 0x20(%rdi)
               	movq	0x28(%rax), %rcx
               	movq	%rcx, 0x28(%rdi)
               	movq	0x30(%rax), %rcx
               	movq	%rcx, 0x30(%rdi)
               	movq	0x38(%rax), %rcx
               	movq	%rcx, 0x38(%rdi)
               	popq	%rcx
               	leaq	0x20(%rdi), %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
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
               	leave
               	retq
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
