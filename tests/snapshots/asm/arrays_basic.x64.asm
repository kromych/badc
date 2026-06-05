
arrays_basic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %rax
               	movq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	xorq	%rsi, %rsi
               	movq	%rsi, %rdx
               	jmp	<addr>
               	movslq	%esi, %rdi
               	cmpq	%rcx, %rdi
               	jge	<addr>
               	movslq	%edx, %rdx
               	movslq	%esi, %rsi
               	movq	%rsi, %rdi
               	shlq	$0x2, %rdi
               	addq	%rax, %rdi
               	movslq	(%rdi), %rdi
               	addq	%rdi, %rdx
               	movslq	%edx, %rdx
               	addq	$0x1, %rsi
               	movslq	%esi, %rsi
               	jmp	<addr>
               	movslq	%edx, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rax
               	addq	$0x1, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, (%rax)
               	movslq	%ecx, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rdi
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x2, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rax
               	imulq	$0xa, %rdx, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, (%rax)
               	movslq	%ecx, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	movq	%rax, %rdx
               	addq	$0x4, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rax, %rdx
               	addq	$0x8, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rax, %rdx
               	addq	$0xc, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	$0x10, %rax
               	movslq	(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x4, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x5, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	xorq	%rcx, %rcx
               	movl	$0x68, %edx
               	movb	%dl, (%rax)
               	movq	%rax, %rdx
               	addq	$0x1, %rdx
               	movl	$0x69, %esi
               	movb	%sil, (%rdx)
               	movq	%rax, %rdx
               	addq	$0x2, %rdx
               	movb	%cl, (%rdx)
               	movzbq	(%rax), %rax
               	xorq	$0x68, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x69, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	leaq	-0x40(%rbp), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rax
               	movl	%edx, (%rax)
               	leaq	-0x40(%rbp), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rax
               	addq	$0x4, %rax
               	imulq	$0x64, %rdx, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, (%rax)
               	movslq	%ecx, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	addq	$0x14, %rax
               	movslq	(%rax), %rax
               	cmpq	$0xc8, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0xc, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rax
               	addq	$0x20, %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	leaq	-0x68(%rbp), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rax
               	addq	$0x1, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, (%rax)
               	leaq	-0x68(%rbp), %rax
               	addq	$0x20, %rax
               	leaq	-0x68(%rbp), %rdx
               	addq	$0x20, %rdx
               	movslq	(%rdx), %rdx
               	leaq	-0x68(%rbp), %rsi
               	movslq	%ecx, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %rsi
               	movslq	(%rsi), %rsi
               	addq	%rsi, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, (%rax)
               	movslq	%ecx, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	leaq	-0x68(%rbp), %rax
               	addq	$0x20, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x24, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	leaq	-0x70(%rbp), %rax
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	addq	$0x41, %rdx
               	movslq	%edx, %rdx
               	movb	%dl, (%rax)
               	movslq	%ecx, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x41, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x7, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x48, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rcx
               	movq	%rax, %rdx
               	addq	$0x4, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
