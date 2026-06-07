
ssa_bail_fixup_rollback.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %rax
               	addq	$0x3, %rax
               	movzbq	(%rax), %rax
               	movl	%eax, %eax
               	shlq	$0x8, %rax
               	movl	%eax, %eax
               	movq	%rdi, %rcx
               	addq	$0x2, %rcx
               	movzbq	(%rcx), %rcx
               	orq	%rcx, %rax
               	movl	%eax, %eax
               	shlq	$0x8, %rax
               	movl	%eax, %eax
               	movq	%rdi, %rcx
               	addq	$0x1, %rcx
               	movzbq	(%rcx), %rcx
               	orq	%rcx, %rax
               	movl	%eax, %eax
               	shlq	$0x8, %rax
               	movl	%eax, %eax
               	movzbq	(%rdi), %rcx
               	orq	%rcx, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movq	%rcx, %r15
               	movq	%rdx, %r14
               	movq	%rsi, %r12
               	xorq	%r10, %r10
               	movq	%r10, 0x68(%rsp)
               	jmp	<addr>
               	movq	0x68(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	movq	0x68(%rsp), %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	addq	$0x1, %r10
               	movq	%r10, 0x68(%rsp)
               	jmp	<addr>
               	leaq	-0x40(%rbp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x68(%rsp), %rax
               	movslq	%eax, %rax
               	leaq	(%rax,%rax,4), %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x58(%rsp)
               	shlq	$0x2, %rax
               	movslq	%eax, %rax
               	movq	%r15, %rdi
               	addq	%rax, %rdi
               	callq	<addr>
               	movq	0x60(%rsp), %r10
               	movq	0x58(%rsp), %r13
               	movl	%eax, (%r10,%r13,4)
               	leaq	-0x40(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x68(%rsp), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	addq	$0x1, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x48(%rsp)
               	shlq	$0x2, %rax
               	movslq	%eax, %rax
               	movq	%r14, %rdi
               	addq	%rax, %rdi
               	callq	<addr>
               	movq	0x50(%rsp), %r10
               	movq	0x48(%rsp), %r13
               	movl	%eax, (%r10,%r13,4)
               	leaq	-0x40(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x68(%rsp), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	addq	$0x6, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x38(%rsp)
               	shlq	$0x2, %rax
               	movslq	%eax, %rax
               	movq	%r12, %rdi
               	addq	%rax, %rdi
               	callq	<addr>
               	movq	0x40(%rsp), %r10
               	movq	0x38(%rsp), %r13
               	movl	%eax, (%r10,%r13,4)
               	leaq	-0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x68(%rsp), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	addq	$0xb, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	%r14, %rcx
               	addq	$0x10, %rcx
               	shlq	$0x2, %rax
               	movslq	%eax, %rax
               	movq	%rcx, %rdi
               	addq	%rax, %rdi
               	callq	<addr>
               	movq	0x30(%rsp), %r10
               	movq	0x28(%rsp), %r13
               	movl	%eax, (%r10,%r13,4)
               	jmp	<addr>
               	xorq	%rax, %rax
               	leaq	-0x40(%rbp), %rcx
               	movl	(%rcx), %ecx
               	leaq	-0x40(%rbp), %rdx
               	addq	$0x14, %rdx
               	movl	(%rdx), %edx
               	xorq	%rdx, %rcx
               	leaq	-0x40(%rbp), %rdx
               	addq	$0x28, %rdx
               	movl	(%rdx), %edx
               	xorq	%rdx, %rcx
               	leaq	-0x40(%rbp), %rdx
               	addq	$0x3c, %rdx
               	movl	(%rdx), %edx
               	xorq	%rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rbx)
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %r12
               	movq	%r8, %rbx
               	movq	%rdx, %r15
               	movq	%rsi, %r14
               	cmpq	$0x0, %r15
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	movl	%edx, %eax
               	cmpq	$0x10, %rax
               	jae	<addr>
               	jmp	<addr>
               	movl	%edx, %eax
               	movq	%rax, %rdx
               	addq	$0x1, %rdx
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rax
               	movl	%edx, %esi
               	addq	%rsi, %rax
               	xorq	%rsi, %rsi
               	movb	%sil, (%rax)
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	movl	%edx, %eax
               	cmpq	$0x8, %rax
               	jae	<addr>
               	jmp	<addr>
               	movl	%edx, %eax
               	movq	%rax, %rdx
               	addq	$0x1, %rdx
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rax
               	movl	%edx, %esi
               	addq	%rsi, %rax
               	addq	%rcx, %rsi
               	movzbq	(%rsi), %rsi
               	movb	%sil, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0x40, %r15
               	jb	<addr>
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x10(%rbp), %rsi
               	leaq	<rip>, %rcx
               	movq	%rbx, %rdx
               	callq	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movl	%ecx, %eax
               	cmpq	$0x40, %rax
               	jae	<addr>
               	jmp	<addr>
               	movl	%ecx, %eax
               	movq	%rax, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	movl	%ecx, %eax
               	addq	%r12, %rax
               	cmpq	$0x0, %r14
               	je	<addr>
               	jmp	<addr>
               	subq	$0x40, %r15
               	addq	$0x40, %r12
               	cmpq	$0x0, %r14
               	je	<addr>
               	jmp	<addr>
               	movl	%ecx, %edx
               	addq	%r14, %rdx
               	movzbq	(%rdx), %rsi
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rdx
               	movl	%ecx, %edi
               	addq	%rdi, %rdx
               	movzbq	(%rdx), %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, (%rax)
               	jmp	<addr>
               	addq	$0x40, %r14
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	popq	%r11
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x20, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	leaq	-0x68(%rbp), %rax
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	andq	$0xff, %rdx
               	movb	%dl, (%rax)
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movl	$0x40, %edx
               	leaq	-0x48(%rbp), %rcx
               	leaq	-0x68(%rbp), %r8
               	callq	<addr>
               	leaq	-0x40(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x4d, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
