
sizeof_pointer_to_array_subscript.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	leaq	-0x70(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x70(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x70(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x70(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x18(%rax)
               	leaq	-0x70(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x20(%rax)
               	leaq	-0x70(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x28(%rax)
               	leaq	-0x70(%rbp), %rax
               	movq	(%rax), %rax
               	addq	$0x8, %rax
               	leaq	-0x70(%rbp), %rcx
               	movq	(%rcx), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	movq	0x8(%rax), %rax
               	addq	$0x10, %rax
               	leaq	-0x70(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	movq	0x10(%rax), %rax
               	addq	$0x20, %rax
               	leaq	-0x70(%rbp), %rcx
               	movq	0x10(%rcx), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x20, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	movq	0x18(%rax), %rax
               	addq	$0x40, %rax
               	leaq	-0x70(%rbp), %rcx
               	movq	0x18(%rcx), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x40, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	movq	0x20(%rax), %rax
               	addq	$0x3c, %rax
               	leaq	-0x70(%rbp), %rcx
               	movq	0x20(%rcx), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	movq	0x20(%rax), %rax
               	addq	$0x14, %rax
               	leaq	-0x70(%rbp), %rcx
               	movq	0x20(%rcx), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	movq	0x28(%rax), %rax
               	addq	$0x18, %rax
               	leaq	-0x70(%rbp), %rcx
               	movq	0x28(%rcx), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x18, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	movq	0x28(%rax), %rax
               	addq	$0xc, %rax
               	leaq	-0x70(%rbp), %rcx
               	movq	0x28(%rcx), %rcx
               	subq	%rcx, %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	movq	0x28(%rax), %rax
               	addq	$0x4, %rax
               	leaq	-0x70(%rbp), %rcx
               	movq	0x28(%rcx), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	addq	$0x3e8, %rsi            # imm = 0x3E8
               	movslq	%esi, %rsi
               	movswq	%si, %rsi
               	movw	%si, (%rax,%rdx,2)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movslq	%ecx, %rdx
               	movswq	(%rax,%rdx,2), %rax
               	addq	$0x3e8, %rdx            # imm = 0x3E8
               	movslq	%edx, %rdx
               	movswq	%dx, %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	addq	$0x14, %rax
               	movslq	%eax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movslq	%ecx, %rdx
               	movswq	(%rax,%rdx,2), %rax
               	addq	$0x3e8, %rdx            # imm = 0x3E8
               	movslq	%edx, %rdx
               	movswq	%dx, %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	addq	$0x1c, %rax
               	movslq	%eax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%edx, %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rax
               	movq	%rax, %rdx
               	incq	%rdx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	movq	0x20(%rax), %rax
               	movslq	%ecx, %rsi
               	imulq	$0x14, %rsi, %rdi
               	addq	%rdi, %rax
               	movslq	%edx, %rdi
               	imulq	$0x64, %rsi, %rsi
               	movslq	%esi, %rsi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, (%rax,%rdi,4)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%edx, %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rax
               	movq	%rax, %rdx
               	incq	%rdx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	movq	0x20(%rax), %rax
               	movslq	%ecx, %rsi
               	imulq	$0x14, %rsi, %rdi
               	addq	%rdi, %rax
               	movslq	%edx, %rdi
               	movslq	(%rax,%rdi,4), %rax
               	imulq	$0x64, %rsi, %rsi
               	movslq	%esi, %rsi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	leaq	(%rax,%rax,4), %rax
               	movslq	%eax, %rax
               	addq	$0x28, %rax
               	movslq	%eax, %rax
               	movslq	%edx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%edx, %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rax
               	movq	%rax, %rdx
               	incq	%rdx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	movq	0x20(%rax), %rax
               	movslq	%ecx, %rsi
               	imulq	$0x14, %rsi, %rdi
               	addq	%rdi, %rax
               	movslq	%edx, %rdi
               	movslq	(%rax,%rdi,4), %rax
               	imulq	$0x64, %rsi, %rsi
               	movslq	%esi, %rsi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	leaq	(%rax,%rax,4), %rax
               	movslq	%eax, %rax
               	addq	$0x3c, %rax
               	movslq	%eax, %rax
               	movslq	%edx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x2, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%edx, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rax
               	movq	%rax, %rdx
               	incq	%rdx
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%esi, %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%esi, %rax
               	movq	%rax, %rsi
               	incq	%rsi
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	movq	0x28(%rax), %rax
               	movslq	%ecx, %rdi
               	imulq	$0xc, %rdi, %rdi
               	addq	%rdi, %rax
               	movslq	%edx, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %rax
               	movslq	%esi, %r9
               	addq	%r9, %rax
               	movslq	%edi, %rdi
               	movslq	%r8d, %r8
               	addq	%r8, %rdi
               	movslq	%edi, %rdi
               	addq	%r9, %rdi
               	movslq	%edi, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x2, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%edx, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rax
               	movq	%rax, %rdx
               	incq	%rdx
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%esi, %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%esi, %rax
               	movq	%rax, %rsi
               	incq	%rsi
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	movq	0x28(%rax), %rax
               	movslq	%ecx, %rdi
               	imulq	$0xc, %rdi, %rdi
               	addq	%rdi, %rax
               	movslq	%edx, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %rax
               	movslq	%esi, %r9
               	addq	%r9, %rax
               	movzbq	(%rax), %rax
               	movslq	%edi, %rdi
               	movslq	%r8d, %r8
               	addq	%r8, %rdi
               	movslq	%edi, %rdi
               	addq	%r9, %rdi
               	movslq	%edi, %rdi
               	andq	$0xff, %rdi
               	cmpq	%rdi, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	imulq	$0xc, %rax, %rax
               	movslq	%eax, %rax
               	addq	$0x50, %rax
               	movslq	%eax, %rax
               	movslq	%edx, %rcx
               	shlq	$0x2, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movslq	%esi, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x2, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movslq	%edx, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rax
               	movq	%rax, %rdx
               	incq	%rdx
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%esi, %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%esi, %rax
               	movq	%rax, %rsi
               	incq	%rsi
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	movq	0x28(%rax), %rax
               	movslq	%ecx, %rdi
               	imulq	$0xc, %rdi, %rdi
               	addq	%rdi, %rax
               	movslq	%edx, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %rax
               	movslq	%esi, %r9
               	addq	%r9, %rax
               	movzbq	(%rax), %rax
               	movslq	%edi, %rdi
               	movslq	%r8d, %r8
               	addq	%r8, %rdi
               	movslq	%edi, %rdi
               	addq	%r9, %rdi
               	movslq	%edi, %rdi
               	andq	$0xff, %rdi
               	cmpq	%rdi, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	imulq	$0xc, %rax, %rax
               	movslq	%eax, %rax
               	addq	$0x6e, %rax
               	movslq	%eax, %rax
               	movslq	%edx, %rcx
               	shlq	$0x2, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movslq	%esi, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
