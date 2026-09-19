
volatile_struct_assign.x64:	file format elf64-x86-64

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
               	leaq	-0x10(%rbp), %rcx
               	movabsq	$0x400000003, %rax      # imm = 0x400000003
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movl	(%rcx), %edx
               	movl	%edx, (%rax)
               	addq	$0x4, %rcx
               	movl	(%rcx), %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x5, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x6, %edx
               	movl	%edx, 0x4(%rax)
               	movq	%rcx, %rsi
               	cmpl	$0x5, %esi
               	jne	<addr>
               	movslq	0x4(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	%ecx, (%rax)
               	addq	$0x4, %rax
               	movl	%edx, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	movl	(%rax), %ecx
               	addq	$0x4, %rax
               	movl	(%rax), %eax
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx
               	cmpl	$0x400, %eax            # imm = 0x400
               	jge	<addr>
               	imulq	$0x7, %rax, %rcx
               	incq	%rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x400, %eax            # imm = 0x400
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx
               	cmpl	$0x100, %eax            # imm = 0x100
               	jge	<addr>
               	imulq	$0xf4243, %rax, %rdx    # imm = 0xF4243
               	subq	$0x5, %rdx
               	movq	%rdx, (%rcx,%rax,8)
               	incq	%rax
               	cmpl	$0x100, %eax            # imm = 0x100
               	jl	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	cmpl	$0x400, %eax            # imm = 0x400
               	jae	<addr>
               	leaq	(%rcx,%rax), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rax), %r8
               	movb	%dil, (%r8)
               	incq	%rax
               	cmpl	$0x400, %eax            # imm = 0x400
               	jb	<addr>
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpl	$0x400, %eax            # imm = 0x400
               	jae	<addr>
               	leaq	(%rcx,%rax), %rsi
               	movzbq	(%rsi), %rsi
               	leaq	(%rdx,%rax), %rdi
               	movb	%sil, (%rdi)
               	incq	%rax
               	cmpl	$0x400, %eax            # imm = 0x400
               	jb	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	cmpl	$0x800, %eax            # imm = 0x800
               	jae	<addr>
               	leaq	(%rcx,%rax), %rdi
               	movq	(%rdi), %rdi
               	leaq	(%rsi,%rax), %r8
               	movq	%rdi, (%r8)
               	addq	$0x8, %rax
               	cmpl	$0x800, %eax            # imm = 0x800
               	jb	<addr>
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpl	$0x800, %eax            # imm = 0x800
               	jae	<addr>
               	leaq	(%rcx,%rax), %rsi
               	movq	(%rsi), %rsi
               	leaq	(%rdx,%rax), %rdi
               	movq	%rsi, (%rdi)
               	addq	$0x8, %rax
               	cmpl	$0x800, %eax            # imm = 0x800
               	jb	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx
               	cmpl	$0x400, %eax            # imm = 0x400
               	jge	<addr>
               	movzbq	(%rdx,%rax), %rsi
               	imulq	$0x7, %rax, %rcx
               	incq	%rcx
               	andq	$0xff, %rcx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x400, %eax            # imm = 0x400
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx
               	cmpl	$0x100, %eax            # imm = 0x100
               	jge	<addr>
               	movq	(%rcx,%rax,8), %rdx
               	imulq	$0xf4243, %rax, %rsi    # imm = 0xF4243
               	subq	$0x5, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x100, %eax            # imm = 0x100
               	jl	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x5, %eax
               	leave
               	retq
