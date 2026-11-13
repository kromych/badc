
dirent_stream.x64:	file format elf64-x86-64

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
               	subq	$0x128, %rsp            # imm = 0x128
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	testq	%r12, %r12
               	jne	<addr>
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	testq	%r12, %r12
               	jne	<addr>
               	leaq	<rip>, %r12
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x11, %eax
               	jne	<addr>
               	cmpl	$0x3e8, %ebx            # imm = 0x3E8
               	je	<addr>
               	incq	%rbx
               	leaq	<rip>, %r13 # <addr>
               	movl	$0x200, %r14d           # imm = 0x200
               	leaq	<rip>, %r15
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	%r10, 0x38(%rsp)
               	xorl	%edi, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r9
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r13, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movq	0x48(%rsp), %r8
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x1c0, %esi            # imm = 0x1C0
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %r8
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %r8
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r14
               	testq	%r14, %r14
               	jne	<addr>
               	movl	$0x4, %r12d
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x0, (%rax)
               	testl	%r12d, %r12d
               	jne	<addr>
               	leaq	<rip>, %r8
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xb, %r12d
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x0, (%rax)
               	testl	%r12d, %r12d
               	jne	<addr>
               	leaq	<rip>, %r8
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0xc, %r12d
               	leaq	<rip>, %r8
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %r8
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%r12d, %r12d
               	movl	%r12d, -0x8(%rbp)
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	incq	%r12
               	leaq	0x13(%rbx), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	orq	$0x1, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	0x13(%rbx), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	orq	$0x2, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	0x13(%rbx), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	orq	$0x4, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	0x13(%rbx), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	orq	$0x8, %rax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	cmpl	$0x4, %r12d
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x5, %r12d
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testl	%r12d, %r12d
               	jne	<addr>
               	xorl	%r13d, %r13d
               	movl	%r13d, -0x8(%rbp)
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	incq	%r13
               	leaq	0x13(%rbx), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	orq	$0x1, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	0x13(%rbx), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	orq	$0x2, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	0x13(%rbx), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	orq	$0x4, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	0x13(%rbx), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	orq	$0x8, %rax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	cmpl	$0x4, %r13d
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x6, %r12d
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testl	%r12d, %r12d
               	jne	<addr>
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movl	$0x7, %r12d
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r13
               	testl	%r12d, %r12d
               	jne	<addr>
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movl	$0x8, %r12d
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testl	%r12d, %r12d
               	jne	<addr>
               	movl	$0xa, %r12d
               	jmp	<addr>
               	testl	%r12d, %r12d
               	jne	<addr>
               	leaq	-0x108(%rbp), %rdi
               	leaq	0x13(%rbx), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%r14, %rdi
               	movq	%r13, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	0x13(%rax), %rdi
               	leaq	-0x108(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %r12d
               	jmp	<addr>
               	xorl	%r12d, %r12d
               	jmp	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
