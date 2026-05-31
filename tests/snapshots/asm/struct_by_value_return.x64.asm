
struct_by_value_return.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003b3 <.text+0x193>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %r11
               	movslq	0x20(%rbp), %r9
               	movl	%r9d, (%r11)
               	leaq	-0x8(%rbp), %r8
               	addq	$0x4, %r8
               	movslq	0x30(%rbp), %r9
               	movl	%r9d, (%r8)
               	movq	0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %r9
               	pushq	%r11
               	movq	(%r9), %r11
               	movq	%r11, (%rax)
               	popq	%r11
               	movq	%rax, %r8
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq
               	movslq	%edi, %r11
               	movl	$0xdead, %r9d           # imm = 0xDEAD
               	movl	$0xbeef, %r8d           # imm = 0xBEEF
               	movl	$0xcafe, %edi           # imm = 0xCAFE
               	movl	$0xfacef, %esi          # imm = 0xFACEF
               	movslq	%r9d, %r9
               	movslq	%r8d, %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	movslq	%edi, %rdi
               	addq	%rdi, %r9
               	movslq	%r9d, %r9
               	movslq	%esi, %rsi
               	addq	%rsi, %r9
               	movslq	%r9d, %r9
               	addq	%r11, %r9
               	movslq	%r9d, %rax
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %r11
               	movq	0x20(%rbp), %r9
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r11)
               	popq	%rax
               	movq	%r11, %r8
               	leaq	-0x10(%rbp), %r8
               	movq	0x30(%rbp), %r9
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r8)
               	popq	%rax
               	movq	%r8, %r11
               	leaq	-0x18(%rbp), %r11
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r8
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %rdi
               	addq	%rdi, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, (%r11)
               	leaq	-0x18(%rbp), %rdi
               	addq	$0x4, %rdi
               	leaq	-0x8(%rbp), %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %r11
               	leaq	-0x10(%rbp), %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %r9
               	addq	%r9, %r11
               	movslq	%r11d, %r11
               	movl	%r11d, (%rdi)
               	movq	0x10(%rbp), %rax
               	leaq	-0x18(%rbp), %r11
               	pushq	%rcx
               	movq	(%r11), %rcx
               	movq	%rcx, (%rax)
               	popq	%rcx
               	movq	%rax, %rdi
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x130, %rsp            # imm = 0x130
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	-0x8(%rbp), %rbx
               	leaq	-0x90(%rbp), %r12
               	movl	$0xb, %r14d
               	movl	$0x16, %r15d
               	movq	%r12, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	callq	0x400237 <.text+0x17>
               	leaq	-0x90(%rbp), %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rbx)
               	popq	%r11
               	movq	%rbx, %r15
               	movl	$0x7, %r12d
               	movq	%r12, %rdi
               	callq	0x4002ad <.text+0x8d>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jne	0x400450 <.text+0x230>
               	movl	$0x63, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %r12
               	cmpq	$0xb, %r12
               	je	0x40048b <.text+0x26b>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r12
               	addq	$0x4, %r12
               	movslq	(%r12), %rax
               	cmpq	$0x16, %rax
               	je	0x4004cf <.text+0x2af>
               	movl	$0x2, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r15
               	leaq	-0xa0(%rbp), %r14
               	movl	$0x3, %r12d
               	movl	$0x4, %ebx
               	movq	%r14, %rdi
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	callq	0x400237 <.text+0x17>
               	leaq	-0xa0(%rbp), %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r15)
               	popq	%r11
               	movq	%r15, %rbx
               	leaq	-0x20(%rbp), %rbx
               	movslq	(%rbx), %rax
               	cmpq	$0x3, %rax
               	je	0x400542 <.text+0x322>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rbx
               	cmpq	$0x4, %rbx
               	je	0x400584 <.text+0x364>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %r14
               	leaq	-0xb0(%rbp), %rbx
               	movl	$0x64, %r12d
               	movl	$0xc8, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	callq	0x400237 <.text+0x17>
               	leaq	-0xb0(%rbp), %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r14)
               	popq	%r11
               	movq	%r14, %r15
               	leaq	-0x38(%rbp), %rbx
               	leaq	-0xc0(%rbp), %r15
               	movl	$0x12c, %r12d           # imm = 0x12C
               	movl	$0x190, %r14d           # imm = 0x190
               	movq	%r15, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	callq	0x400237 <.text+0x17>
               	leaq	-0xc0(%rbp), %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rbx)
               	popq	%r11
               	movq	%rbx, %r14
               	leaq	-0x30(%rbp), %r14
               	movslq	(%r14), %rax
               	cmpq	$0x64, %rax
               	je	0x400632 <.text+0x412>
               	movl	$0x5, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r14
               	cmpq	$0xc8, %r14
               	je	0x400674 <.text+0x454>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %r14
               	movslq	(%r14), %rax
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	je	0x4006b0 <.text+0x490>
               	movl	$0x7, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r14
               	cmpq	$0x190, %r14            # imm = 0x190
               	je	0x4006f2 <.text+0x4d2>
               	movl	$0x8, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	leaq	-0xd0(%rbp), %r14
               	leaq	-0xe0(%rbp), %r12
               	movl	$0x1, %ebx
               	movl	$0x2, %r15d
               	movq	%r12, %rdi
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	callq	0x400237 <.text+0x17>
               	leaq	-0xe0(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	leaq	-0xf0(%rbp), %rbx
               	movl	$0x3, %r15d
               	movl	$0x4, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	callq	0x400237 <.text+0x17>
               	leaq	-0xf0(%rbp), %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rdx
               	movq	0x20(%rsp), %rsi
               	callq	0x4002eb <.text+0xcb>
               	leaq	-0xd0(%rbp), %rax
               	movq	0x28(%rsp), %r10
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r10)
               	popq	%r11
               	movq	%r10, %rbx
               	leaq	-0x50(%rbp), %rbx
               	movslq	(%rbx), %rax
               	cmpq	$0x4, %rax
               	je	0x4007ba <.text+0x59a>
               	movl	$0x9, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rbx
               	cmpq	$0x6, %rbx
               	je	0x4007fc <.text+0x5dc>
               	movl	$0xa, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
