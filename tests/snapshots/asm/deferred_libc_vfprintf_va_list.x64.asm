
deferred_libc_vfprintf_va_list.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	(%rax), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%r12, %rcx
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	%rdi, %rax
               	movq	%rdx, %r8
               	movq	%rsi, %rdi
               	movslq	%edi, %rdi
               	movslq	%r8d, %r8
               	movslq	%ecx, %rcx
               	movslq	%edi, %rdx
               	addq	%rax, %rdx
               	xorq	%rsi, %rsi
               	movb	%sil, (%rdx)
               	cmpq	$0x0, %r8
               	jne	<addr>
               	movslq	%edi, %rcx
               	subq	$0x1, %rcx
               	movslq	%ecx, %rcx
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	movl	$0x30, %edx
               	movb	%dl, (%rax)
               	movslq	%ecx, %rax
               	retq
               	jmp	<addr>
               	movslq	%r8d, %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	cmpq	$0xa, %rcx
               	jne	<addr>
               	jmp	<addr>
               	movslq	%edi, %rax
               	retq
               	movslq	%r8d, %rdx
               	movl	$0xa, %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %r9
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	jmp	<addr>
               	movslq	%edi, %rdx
               	subq	$0x1, %rdx
               	movslq	%edx, %rdi
               	movslq	%r9d, %rdx
               	cmpq	$0xa, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%r8d, %rdx
               	movq	%rdx, %r9
               	andq	$0xf, %r9
               	sarq	$0x4, %rdx
               	movabsq	$0xfffffffffffffff, %r8 # imm = 0xFFFFFFFFFFFFFFF
               	andq	%rdx, %r8
               	jmp	<addr>
               	movslq	%edi, %rdx
               	addq	%rax, %rdx
               	movslq	%r9d, %rsi
               	addq	$0x30, %rsi
               	movslq	%esi, %rsi
               	movb	%sil, (%rdx)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%edi, %rdx
               	addq	%rax, %rdx
               	movslq	%r9d, %rsi
               	addq	$0x61, %rsi
               	movslq	%esi, %rsi
               	subq	$0xa, %rsi
               	movslq	%esi, %rsi
               	movb	%sil, (%rdx)
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %rax
               	movq	%rcx, %r10
               	movq	%rsi, %rcx
               	movq	%r10, %rsi
               	movslq	%ecx, %rcx
               	movslq	%esi, %rsi
               	cmpq	$0x0, %rcx
               	setg	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movslq	(%rdx), %rdi
               	addq	$0x1, %rdi
               	movslq	%edi, %rdi
               	cmpq	%rcx, %rdi
               	setl	%r8b
               	movzbq	%r8b, %r8
               	jmp	<addr>
               	cmpq	$0x0, %r8
               	je	<addr>
               	movslq	(%rdx), %rcx
               	addq	%rcx, %rax
               	movq	%rsi, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rax)
               	jmp	<addr>
               	movslq	(%rdx), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, (%rdx)
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rcx, (%rsp)
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x320, %rsp            # imm = 0x320
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movq	%rcx, %rax
               	movq	%rdx, %r14
               	movq	%rsi, %r12
               	movslq	%r12d, %r12
               	movq	%rax, 0x40(%rbp)
               	xorq	%r15, %r15
               	movl	%r15d, -0x8(%rbp)
               	jmp	<addr>
               	movslq	%r15d, %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movslq	%r15d, %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	xorq	$0x25, %rcx
               	movl	%ecx, %ecx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x0, %r12
               	jle	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movslq	%r15d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r15
               	jmp	<addr>
               	movslq	%r15d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r15
               	xorq	%r10, %r10
               	movq	%r10, 0x148(%rsp)
               	movq	0x148(%rsp), %r13
               	movq	%r13, 0x140(%rsp)
               	jmp	<addr>
               	movslq	%r15d, %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x2d, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x138(%rsp)
               	movq	0x138(%rsp), %r10
               	cmpq	$0x0, %r10
               	jne	<addr>
               	jmp	<addr>
               	movslq	%r15d, %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x2d, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r10, %r10
               	movq	%r10, 0x130(%rsp)
               	movslq	%r15d, %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x2a, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movslq	%r15d, %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x30, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x138(%rsp)
               	jmp	<addr>
               	movq	0x138(%rsp), %r10
               	cmpq	$0x0, %r10
               	jne	<addr>
               	movslq	%r15d, %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x2b, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x138(%rsp)
               	jmp	<addr>
               	movq	0x138(%rsp), %r10
               	cmpq	$0x0, %r10
               	jne	<addr>
               	movslq	%r15d, %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x20, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x138(%rsp)
               	jmp	<addr>
               	movq	0x138(%rsp), %r10
               	cmpq	$0x0, %r10
               	jne	<addr>
               	movslq	%r15d, %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x23, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x138(%rsp)
               	jmp	<addr>
               	movq	0x138(%rsp), %r10
               	cmpq	$0x0, %r10
               	je	<addr>
               	jmp	<addr>
               	movl	$0x1, %r10d
               	movq	%r10, 0x140(%rsp)
               	jmp	<addr>
               	movslq	%r15d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r15
               	jmp	<addr>
               	movslq	%r15d, %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x30, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x1, %r10d
               	movq	%r10, 0x148(%rsp)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x40(%rbp), %rax
               	movq	%rax, %r13
               	movq	(%r13), %rax
               	leaq	0x10(%rax), %r10
               	movq	%r10, (%r13)
               	movslq	(%rax), %r10
               	movq	%r10, 0x130(%rsp)
               	movq	0x130(%rsp), %rax
               	cmpq	$0x0, %rax
               	jge	<addr>
               	jmp	<addr>
               	xorq	%r10, %r10
               	movq	%r10, 0x118(%rsp)
               	movslq	%r15d, %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x2e, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %r10d
               	movq	%r10, 0x140(%rsp)
               	movq	0x130(%rsp), %r10
               	imulq	$-0x1, %r10, %r10
               	movq	%r10, 0x130(%rsp)
               	jmp	<addr>
               	movslq	%r15d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r15
               	jmp	<addr>
               	movslq	%r15d, %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x30, %rax
               	setge	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x128(%rsp)
               	movq	0x128(%rsp), %r10
               	cmpq	$0x0, %r10
               	je	<addr>
               	jmp	<addr>
               	movq	0x130(%rsp), %rax
               	movslq	%eax, %rax
               	imulq	$0xa, %rax, %rax
               	movslq	%eax, %rax
               	movslq	%r15d, %rcx
               	movq	%r14, %rdx
               	addq	%rcx, %rdx
               	movzbq	(%rdx), %rdx
               	subq	$0x30, %rdx
               	movslq	%edx, %rdx
               	addq	%rdx, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x130(%rsp)
               	movq	%rcx, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r15
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r15d, %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x39, %rax
               	setle	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x128(%rsp)
               	jmp	<addr>
               	movq	0x128(%rsp), %r10
               	cmpq	$0x0, %r10
               	je	<addr>
               	jmp	<addr>
               	movl	$0x1, %r10d
               	movq	%r10, 0x120(%rsp)
               	movslq	%r15d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r15
               	movslq	%r15d, %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x2a, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x40(%rbp), %rax
               	movq	%rax, %r13
               	movq	(%r13), %rax
               	leaq	0x10(%rax), %r10
               	movq	%r10, (%r13)
               	movslq	(%rax), %r10
               	movq	%r10, 0x110(%rsp)
               	movq	0x110(%rsp), %rax
               	cmpq	$0x0, %rax
               	jge	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x118(%rsp), %r13
               	movq	%r13, 0x110(%rsp)
               	jmp	<addr>
               	xorq	%r10, %r10
               	movq	%r10, 0x118(%rsp)
               	movq	0x118(%rsp), %r13
               	movq	%r13, 0x110(%rsp)
               	jmp	<addr>
               	movslq	%r15d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r15
               	jmp	<addr>
               	movslq	%r15d, %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x30, %rax
               	setge	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x108(%rsp)
               	movq	0x108(%rsp), %r10
               	cmpq	$0x0, %r10
               	je	<addr>
               	jmp	<addr>
               	movq	0x110(%rsp), %rax
               	movslq	%eax, %rax
               	imulq	$0xa, %rax, %rax
               	movslq	%eax, %rax
               	movslq	%r15d, %rcx
               	movq	%r14, %rdx
               	addq	%rcx, %rdx
               	movzbq	(%rdx), %rdx
               	subq	$0x30, %rdx
               	movslq	%edx, %rdx
               	addq	%rdx, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x110(%rsp)
               	movq	%rcx, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r15
               	jmp	<addr>
               	movq	0x120(%rsp), %r13
               	movq	%r13, 0x118(%rsp)
               	jmp	<addr>
               	movslq	%r15d, %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x39, %rax
               	setle	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x108(%rsp)
               	jmp	<addr>
               	movq	0x108(%rsp), %r10
               	cmpq	$0x0, %r10
               	je	<addr>
               	jmp	<addr>
               	movslq	%r15d, %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x6c, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0xf8(%rsp)
               	movq	0xf8(%rsp), %r10
               	cmpq	$0x0, %r10
               	jne	<addr>
               	jmp	<addr>
               	movslq	%r15d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r15
               	jmp	<addr>
               	movslq	%r15d, %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %r10
               	movq	%r10, 0x100(%rsp)
               	movq	0x100(%rsp), %rax
               	andq	$0xff, %rax
               	xorq	$0x64, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movslq	%r15d, %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x68, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0xf8(%rsp)
               	jmp	<addr>
               	movq	0xf8(%rsp), %r10
               	cmpq	$0x0, %r10
               	jne	<addr>
               	movslq	%r15d, %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x7a, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0xf8(%rsp)
               	jmp	<addr>
               	movq	0xf8(%rsp), %r10
               	cmpq	$0x0, %r10
               	jne	<addr>
               	movslq	%r15d, %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x6a, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0xf8(%rsp)
               	jmp	<addr>
               	movq	0xf8(%rsp), %r10
               	cmpq	$0x0, %r10
               	jne	<addr>
               	movslq	%r15d, %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x74, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0xf8(%rsp)
               	jmp	<addr>
               	movq	0xf8(%rsp), %r10
               	cmpq	$0x0, %r10
               	je	<addr>
               	jmp	<addr>
               	leaq	0x40(%rbp), %rax
               	movq	%rax, %r13
               	movq	(%r13), %rax
               	leaq	0x10(%rax), %r10
               	movq	%r10, (%r13)
               	movslq	(%rax), %r10
               	movq	%r10, 0xe8(%rsp)
               	xorq	%r10, %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xe8(%rsp), %rax
               	cmpq	$0x0, %rax
               	jge	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x100(%rsp), %rax
               	andq	$0xff, %rax
               	xorq	$0x75, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0xa8(%rsp)
               	movq	0xa8(%rsp), %r10
               	cmpq	$0x0, %r10
               	jne	<addr>
               	jmp	<addr>
               	movl	$0x1, %r10d
               	movq	%r10, 0xf0(%rsp)
               	movq	0xe8(%rsp), %r10
               	imulq	$-0x1, %r10, %r10
               	movq	%r10, 0xe8(%rsp)
               	jmp	<addr>
               	leaq	-0x90(%rbp), %rdi
               	movl	$0x1f, %r10d
               	movq	%r10, 0xe0(%rsp)
               	movq	0xe8(%rsp), %rdx
               	movslq	%edx, %rdx
               	movl	$0xa, %ecx
               	movq	0xe0(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, 0xb0(%rsp)
               	movq	0xb0(%rsp), %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0xe0(%rsp), %rax
               	subq	%r10, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0xf0(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	0xd8(%rsp), %rax
               	movslq	%eax, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0xd8(%rsp)
               	jmp	<addr>
               	movq	0x118(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	0x110(%rsp), %rcx
               	movslq	%ecx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%r10, %r10
               	movq	%r10, 0xd0(%rsp)
               	movq	0xd8(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0xf0(%rsp), %rdx
               	movslq	%edx, %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	movl	$0x1, %esi
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	subq	%rsi, %rax
               	movslq	%eax, %rax
               	movslq	%ecx, %rdx
               	cmpq	%rdx, %rax
               	jge	<addr>
               	movslq	%ecx, %rax
               	movq	0xd8(%rsp), %rcx
               	movslq	%ecx, %rcx
               	movq	0xf0(%rsp), %rdx
               	movslq	%edx, %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	jmp	<addr>
               	movq	0x130(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0xd8(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jle	<addr>
               	jmp	<addr>
               	movl	$0x1, %esi
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	subq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	subq	%rcx, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0xd0(%rsp)
               	movq	0xd8(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0xd0(%rsp), %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0xd8(%rsp)
               	jmp	<addr>
               	movq	0x130(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0xd8(%rsp), %rcx
               	movslq	%ecx, %rcx
               	subq	%rcx, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0xc8(%rsp)
               	jmp	<addr>
               	xorq	%r10, %r10
               	movq	%r10, 0xc8(%rsp)
               	jmp	<addr>
               	movq	0x148(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0xc0(%rsp)
               	movq	0xc0(%rsp), %r10
               	cmpq	$0x0, %r10
               	je	<addr>
               	movq	0x118(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0xc0(%rsp)
               	jmp	<addr>
               	movq	0xc0(%rsp), %r10
               	cmpq	$0x0, %r10
               	je	<addr>
               	movq	0x140(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0xc0(%rsp)
               	jmp	<addr>
               	movq	0xc0(%rsp), %r10
               	cmpq	$0x0, %r10
               	je	<addr>
               	movl	$0x30, %r10d
               	movq	%r10, 0xb8(%rsp)
               	jmp	<addr>
               	movl	$0x20, %r10d
               	movq	%r10, 0xb8(%rsp)
               	jmp	<addr>
               	movq	0x140(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	0xf0(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movq	0xc8(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jle	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movq	0xb8(%rsp), %rcx
               	andq	$0xff, %rcx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	0xc8(%rsp), %rax
               	movslq	%eax, %rax
               	subq	$0x1, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0xc8(%rsp)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x2d, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	0xd0(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jle	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x30, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	0xd0(%rsp), %rax
               	movslq	%eax, %rax
               	subq	$0x1, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0xd0(%rsp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	0xb0(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x1f, %rax
               	jge	<addr>
               	leaq	-0x8(%rbp), %rdx
               	leaq	-0x90(%rbp), %rax
               	movq	0xb0(%rsp), %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rcx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	0xb0(%rsp), %rax
               	movslq	%eax, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0xb0(%rsp)
               	jmp	<addr>
               	movq	0x140(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	%r15d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r15
               	jmp	<addr>
               	movq	0xc8(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jle	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x20, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	0xc8(%rsp), %rax
               	movslq	%eax, %rax
               	subq	$0x1, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0xc8(%rsp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x100(%rsp), %rax
               	andq	$0xff, %rax
               	xorq	$0x78, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0xa8(%rsp)
               	jmp	<addr>
               	movq	0xa8(%rsp), %r10
               	cmpq	$0x0, %r10
               	jne	<addr>
               	movq	0x100(%rsp), %rax
               	andq	$0xff, %rax
               	xorq	$0x58, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0xa8(%rsp)
               	jmp	<addr>
               	movq	0xa8(%rsp), %r10
               	cmpq	$0x0, %r10
               	je	<addr>
               	leaq	0x40(%rbp), %rax
               	movq	%rax, %r13
               	movq	(%r13), %rax
               	leaq	0x10(%rax), %r10
               	movq	%r10, (%r13)
               	movslq	(%rax), %rdx
               	leaq	-0x90(%rbp), %rdi
               	movl	$0x1f, %esi
               	movq	0x100(%rsp), %rax
               	andq	$0xff, %rax
               	xorq	$0x75, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x100(%rsp), %rax
               	andq	$0xff, %rax
               	xorq	$0x70, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0xa, %ecx
               	jmp	<addr>
               	movl	$0x10, %ecx
               	jmp	<addr>
               	callq	<addr>
               	movq	%rax, 0x78(%rsp)
               	movl	$0x1f, %eax
               	movq	0x78(%rsp), %rcx
               	movslq	%ecx, %rcx
               	subq	%rcx, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x98(%rsp)
               	movq	0x118(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	0x110(%rsp), %rcx
               	movslq	%ecx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%r10, %r10
               	movq	%r10, 0xa0(%rsp)
               	movq	0x98(%rsp), %rax
               	movslq	%eax, %rax
               	movslq	%ecx, %rdx
               	cmpq	%rdx, %rax
               	jge	<addr>
               	movslq	%ecx, %rax
               	movq	0x98(%rsp), %rcx
               	movslq	%ecx, %rcx
               	subq	%rcx, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0xa0(%rsp)
               	movq	0xa0(%rsp), %rax
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x98(%rsp)
               	jmp	<addr>
               	movq	0x130(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x98(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jle	<addr>
               	movq	0x130(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x98(%rsp), %rcx
               	movslq	%ecx, %rcx
               	subq	%rcx, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x90(%rsp)
               	jmp	<addr>
               	xorq	%r10, %r10
               	movq	%r10, 0x90(%rsp)
               	jmp	<addr>
               	movq	0x148(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x88(%rsp)
               	movq	0x88(%rsp), %r10
               	cmpq	$0x0, %r10
               	je	<addr>
               	movq	0x118(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x88(%rsp)
               	jmp	<addr>
               	movq	0x88(%rsp), %r10
               	cmpq	$0x0, %r10
               	je	<addr>
               	movq	0x140(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x88(%rsp)
               	jmp	<addr>
               	movq	0x88(%rsp), %r10
               	cmpq	$0x0, %r10
               	je	<addr>
               	movl	$0x30, %r10d
               	movq	%r10, 0x80(%rsp)
               	jmp	<addr>
               	movl	$0x20, %r10d
               	movq	%r10, 0x80(%rsp)
               	jmp	<addr>
               	movq	0x140(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x90(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jle	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movq	0x80(%rsp), %rcx
               	andq	$0xff, %rcx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	0x90(%rsp), %rax
               	movslq	%eax, %rax
               	subq	$0x1, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x90(%rsp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	0xa0(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jle	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x30, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	0xa0(%rsp), %rax
               	movslq	%eax, %rax
               	subq	$0x1, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0xa0(%rsp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x78(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x1f, %rax
               	jge	<addr>
               	leaq	-0x8(%rbp), %rdx
               	leaq	-0x90(%rbp), %rax
               	movq	0x78(%rsp), %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rcx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	0x78(%rsp), %rax
               	movslq	%eax, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x78(%rsp)
               	jmp	<addr>
               	movq	0x140(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	%r15d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r15
               	jmp	<addr>
               	movq	0x90(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jle	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x20, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	0x90(%rsp), %rax
               	movslq	%eax, %rax
               	subq	$0x1, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x90(%rsp)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x40(%rbp), %rax
               	movq	%rax, %r13
               	movq	(%r13), %rax
               	leaq	0x10(%rax), %r10
               	movq	%r10, (%r13)
               	movslq	(%rax), %r10
               	movq	%r10, 0x70(%rsp)
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x30, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x78, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movl	$0xf, %r10d
               	movq	%r10, 0x68(%rsp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x100(%rsp), %rax
               	andq	$0xff, %rax
               	xorq	$0x63, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	0x68(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jl	<addr>
               	movq	0x68(%rsp), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0x70(%rsp), %rax
               	movq	%r10, %rcx
               	sarq	%cl, %rax
               	movq	%rax, %r10
               	andq	$0xf, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x60(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0xa, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%r15d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r15
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movq	0x60(%rsp), %rax
               	movslq	%eax, %rax
               	addq	$0x30, %rax
               	movslq	%eax, %rcx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	jmp	<addr>
               	movq	0x68(%rsp), %rax
               	movslq	%eax, %rax
               	subq	$0x1, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x68(%rsp)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movq	0x60(%rsp), %rax
               	movslq	%eax, %rax
               	addq	$0x61, %rax
               	movslq	%eax, %rax
               	subq	$0xa, %rax
               	movslq	%eax, %rcx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	jmp	<addr>
               	leaq	0x40(%rbp), %rax
               	movq	%rax, %r13
               	movq	(%r13), %rax
               	leaq	0x10(%rax), %r10
               	movq	%r10, (%r13)
               	movslq	(%rax), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x130(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	jle	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x100(%rsp), %rax
               	andq	$0xff, %rax
               	xorq	$0x73, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	0x130(%rsp), %rax
               	movslq	%eax, %rax
               	subq	$0x1, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x50(%rsp)
               	jmp	<addr>
               	xorq	%r10, %r10
               	movq	%r10, 0x50(%rsp)
               	jmp	<addr>
               	movq	0x140(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movq	0x58(%rsp), %rcx
               	callq	<addr>
               	movq	0x140(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movq	0x50(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jle	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x20, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	0x50(%rsp), %rax
               	movslq	%eax, %rax
               	subq	$0x1, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x50(%rsp)
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r15d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r15
               	jmp	<addr>
               	movq	0x50(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jle	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x20, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	0x50(%rsp), %rax
               	movslq	%eax, %rax
               	subq	$0x1, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x50(%rsp)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x40(%rbp), %rax
               	movq	%rax, %r13
               	movq	(%r13), %rax
               	leaq	0x10(%rax), %r10
               	movq	%r10, (%r13)
               	movq	(%rax), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x100(%rsp), %rax
               	andq	$0xff, %rax
               	xorq	$0x25, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r10
               	movq	%r10, 0x48(%rsp)
               	jmp	<addr>
               	xorq	%r10, %r10
               	movq	%r10, 0x40(%rsp)
               	jmp	<addr>
               	movq	0x40(%rsp), %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0x48(%rsp), %rax
               	addq	%r10, %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	0x40(%rsp), %rax
               	movslq	%eax, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x40(%rsp)
               	jmp	<addr>
               	movq	0x118(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	cmpq	$0x0, %r10
               	je	<addr>
               	movq	0x110(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x40(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	setl	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x38(%rsp)
               	jmp	<addr>
               	movq	0x38(%rsp), %r10
               	cmpq	$0x0, %r10
               	je	<addr>
               	movq	0x110(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x40(%rsp)
               	jmp	<addr>
               	movq	0x130(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x40(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jle	<addr>
               	movq	0x130(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x40(%rsp), %rcx
               	movslq	%ecx, %rcx
               	subq	%rcx, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x30(%rsp)
               	jmp	<addr>
               	xorq	%r10, %r10
               	movq	%r10, 0x30(%rsp)
               	jmp	<addr>
               	movq	0x140(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r10, %r10
               	movq	%r10, 0x28(%rsp)
               	jmp	<addr>
               	movq	0x30(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jle	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x20, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	0x30(%rsp), %rax
               	movslq	%eax, %rax
               	subq	$0x1, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x30(%rsp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x28(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x40(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movq	0x28(%rsp), %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0x48(%rsp), %rax
               	addq	%r10, %rax
               	movzbq	(%rax), %rcx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	0x28(%rsp), %rax
               	movslq	%eax, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x28(%rsp)
               	jmp	<addr>
               	movq	0x140(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	%r15d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r15
               	jmp	<addr>
               	movq	0x30(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jle	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x20, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	0x30(%rsp), %rax
               	movslq	%eax, %rax
               	subq	$0x1, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x30(%rsp)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x25, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movslq	%r15d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r15
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x100(%rsp), %rax
               	andq	$0xff, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x25, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movq	0x100(%rsp), %rcx
               	andq	$0xff, %rcx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movslq	%r15d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r15
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	cmpq	%r12, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x320, %rsp            # imm = 0x320
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	movslq	-0x8(%rbp), %rax
               	addq	%rbx, %rax
               	xorq	%rcx, %rcx
               	movb	%cl, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	%r12, %rax
               	subq	$0x1, %rax
               	movslq	%eax, %rax
               	addq	%rbx, %rax
               	xorq	%rcx, %rcx
               	movb	%cl, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x118(%rsp), %r13
               	movq	%r13, 0x110(%rsp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x120(%rsp), %r13
               	movq	%r13, 0x118(%rsp)
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	0x30(%rbp), %rcx
               	leaq	0x10(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	0x10(%rbp), %rdi
               	movslq	0x20(%rbp), %rsi
               	movq	0x30(%rbp), %rdx
               	movq	-0x8(%rbp), %rcx
               	callq	<addr>
               	leaq	-0x8(%rbp), %rcx
               	movslq	%eax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movl	$0x2a, %ecx
               	movl	$0x63, %r8d
               	subq	$0x10, %rsp
               	movq	%r8, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rcx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	callq	<addr>
               	addq	$0x50, %rsp
               	leaq	-0x40(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x40(%rbp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
