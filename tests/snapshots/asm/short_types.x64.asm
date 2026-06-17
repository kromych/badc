
short_types.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x270, %esi            # imm = 0x270
               	callq	<addr>
               	ud2

<__c5_lazy_stream>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	(%r12,%rbx,8), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax,%rbx,8), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, (%r12,%rbx,8)
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq

<as_short>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movslq	%eax, %rcx
               	andq	$0x8000, %rcx           # imm = 0x8000
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%eax, %rax
               	subq	$0x10000, %rax          # imm = 0x10000
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<as_ushort>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r13, 0x8(%rsp)
               	movl	$0x4d2, %eax            # imm = 0x4D2
               	movabsq	$-0x2a, %rcx
               	cmpq	$0x4d2, %rax            # imm = 0x4D2
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$-0x2a, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rdx
               	addq	%rcx, %rdx
               	movslq	%edx, %rdx
               	movswq	%dx, %rdx
               	cmpq	$0x4a8, %rdx            # imm = 0x4A8
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	movslq	%edx, %rdx
               	movswq	%dx, %rdx
               	cmpq	$0x4fc, %rdx            # imm = 0x4FC
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	(%rcx,%rcx,2), %rcx
               	movslq	%ecx, %rcx
               	movswq	%cx, %rcx
               	cmpq	$-0x7e, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %ecx
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movswq	%cx, %rcx
               	cmpq	$0xb0, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %ecx
               	pushq	%rdx
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rax
               	popq	%rdx
               	movswq	%ax, %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %ebx
               	movq	%rbx, %rax
               	shlq	$0xe, %rax
               	movslq	%eax, %rax
               	movswq	%ax, %rax
               	cmpq	$0x4000, %rax           # imm = 0x4000
               	je	<addr>
               	movl	$0x8, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rax
               	shlq	$0x10, %rax
               	movslq	%eax, %rdi
               	callq	<addr>
               	movswq	%ax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rax
               	shlq	$0xf, %rax
               	movslq	%eax, %rdi
               	callq	<addr>
               	movswq	%ax, %rax
               	cmpq	$-0x8000, %rax          # imm = 0x8000
               	je	<addr>
               	movl	$0xa, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x8, %rax
               	sarq	$0x1, %rax
               	movswq	%ax, %rax
               	cmpq	$-0x4, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xfffe, %eax           # imm = 0xFFFE
               	movl	$0x1, %ecx
               	movq	%rax, %rdx
               	addq	%rcx, %rdx
               	movslq	%edx, %rdx
               	movslq	%edx, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	xorq	$0xffff, %rdx           # imm = 0xFFFF
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xc, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	incq	%rax
               	movslq	%eax, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	movl	$0x1, %edx
               	movq	%rdx, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movslq	%esi, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0xe, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movslq	%eax, %rsi
               	cmpq	$0xffff, %rsi           # imm = 0xFFFF
               	je	<addr>
               	movl	$0xf, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movslq	%eax, %rax
               	movl	%eax, %eax
               	cmpq	%rdx, %rax
               	ja	<addr>
               	movl	$0x10, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	shlq	$0xf, %rax
               	movslq	%eax, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	$0x8000, %rax           # imm = 0x8000
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8000, %eax           # imm = 0x8000
               	movslq	%eax, %rax
               	sarq	$0x1, %rax
               	movslq	%eax, %rax
               	cmpq	$0x4000, %rax           # imm = 0x4000
               	je	<addr>
               	movl	$0x12, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xd8(%rbp), %rax
               	movl	$0x64, %ecx
               	movw	%cx, (%rax)
               	leaq	-0xd8(%rbp), %rax
               	movl	$0xc8, %ecx
               	movw	%cx, 0x2(%rax)
               	leaq	-0xd8(%rbp), %rax
               	movabsq	$-0x12c, %rcx           # imm = 0xFED4
               	movw	%cx, 0x4(%rax)
               	leaq	-0xd8(%rbp), %rbx
               	leaq	-0xd8(%rbp), %rax
               	movswq	(%rax), %rax
               	leaq	-0xd8(%rbp), %rcx
               	movswq	0x2(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	leaq	-0xd8(%rbp), %rcx
               	movswq	0x4(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rdi
               	callq	<addr>
               	movw	%ax, 0x6(%rbx)
               	leaq	-0xd8(%rbp), %rax
               	movswq	0x6(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xe0(%rbp), %rax
               	movl	$0x7, %ecx
               	movw	%cx, (%rax)
               	leaq	-0xe0(%rbp), %rax
               	movabsq	$-0x7, %rcx
               	movw	%cx, 0x2(%rax)
               	leaq	-0xe0(%rbp), %rax
               	movl	$0xc0de, %ecx           # imm = 0xC0DE
               	movw	%cx, 0x4(%rax)
               	leaq	-0xe0(%rbp), %rax
               	movswq	(%rax), %rax
               	leaq	-0xe0(%rbp), %rcx
               	movswq	0x2(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xe0(%rbp), %rax
               	movzwq	0x4(%rax), %rax
               	xorq	$0xc0de, %rax           # imm = 0xC0DE
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
