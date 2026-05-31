
struct_by_value_return.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
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
               	movslq	(%r9), %r9
               	leaq	-0x10(%rbp), %r8
               	movslq	(%r8), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, (%r11)
               	leaq	-0x18(%rbp), %r8
               	addq	$0x4, %r8
               	leaq	-0x8(%rbp), %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %r9
               	leaq	-0x10(%rbp), %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %r11
               	addq	%r11, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, (%r8)
               	movq	0x10(%rbp), %rax
               	leaq	-0x18(%rbp), %r9
               	pushq	%r11
               	movq	(%r9), %r11
               	movq	%r11, (%rax)
               	popq	%r11
               	movq	%rax, %r8
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
               	callq	<addr>
               	leaq	-0x90(%rbp), %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rbx)
               	popq	%r11
               	movq	%rbx, %r15
               	movl	$0x7, %r15d
               	movl	$0xdead, %eax           # imm = 0xDEAD
               	movl	$0xbeef, %ebx           # imm = 0xBEEF
               	movl	$0xcafe, %r14d          # imm = 0xCAFE
               	movl	$0xfacef, %r12d         # imm = 0xFACEF
               	movslq	%eax, %rax
               	movslq	%ebx, %rbx
               	addq	%rbx, %rax
               	movslq	%eax, %rax
               	movslq	%r14d, %r14
               	addq	%r14, %rax
               	movslq	%eax, %rax
               	movslq	%r12d, %r12
               	addq	%r12, %rax
               	movslq	%eax, %rax
               	addq	%r15, %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x63, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x1, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0x2, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rbx
               	leaq	-0xa0(%rbp), %r14
               	movl	$0x3, %r15d
               	movl	$0x4, %r12d
               	movq	%r14, %rdi
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	callq	<addr>
               	leaq	-0xa0(%rbp), %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rbx)
               	popq	%r11
               	movq	%rbx, %r12
               	leaq	-0x20(%rbp), %r12
               	movslq	(%r12), %r12
               	cmpq	$0x3, %r12
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r12
               	addq	$0x4, %r12
               	movslq	(%r12), %r12
               	cmpq	$0x4, %r12
               	je	<addr>
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
               	leaq	-0xb0(%rbp), %r12
               	movl	$0x64, %r15d
               	movl	$0xc8, %ebx
               	movq	%r12, %rdi
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	callq	<addr>
               	leaq	-0xb0(%rbp), %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r14)
               	popq	%r11
               	movq	%r14, %rbx
               	leaq	-0x38(%rbp), %r12
               	leaq	-0xc0(%rbp), %rbx
               	movl	$0x12c, %r15d           # imm = 0x12C
               	movl	$0x190, %r14d           # imm = 0x190
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	callq	<addr>
               	leaq	-0xc0(%rbp), %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r12)
               	popq	%r11
               	movq	%r12, %r14
               	leaq	-0x30(%rbp), %r14
               	movslq	(%r14), %r14
               	cmpq	$0x64, %r14
               	je	<addr>
               	movl	$0x5, %eax
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
               	addq	$0x4, %r14
               	movslq	(%r14), %r14
               	cmpq	$0xc8, %r14
               	je	<addr>
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
               	movslq	(%r14), %r14
               	cmpq	$0x12c, %r14            # imm = 0x12C
               	je	<addr>
               	movl	$0x7, %eax
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
               	addq	$0x4, %r14
               	movslq	(%r14), %r14
               	cmpq	$0x190, %r14            # imm = 0x190
               	je	<addr>
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
               	leaq	-0xe0(%rbp), %r15
               	movl	$0x1, %r12d
               	movl	$0x2, %ebx
               	movq	%r15, %rdi
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	-0xe0(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	leaq	-0xf0(%rbp), %r12
               	movl	$0x3, %ebx
               	movl	$0x4, %r15d
               	movq	%r12, %rdi
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	-0xf0(%rbp), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rdx
               	movq	0x20(%rsp), %rsi
               	callq	<addr>
               	leaq	-0xd0(%rbp), %rax
               	movq	0x28(%rsp), %r10
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r10)
               	popq	%r11
               	movq	%r10, %r12
               	leaq	-0x50(%rbp), %r12
               	movslq	(%r12), %r12
               	cmpq	$0x4, %r12
               	je	<addr>
               	movl	$0x9, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %r12
               	addq	$0x4, %r12
               	movslq	(%r12), %r12
               	cmpq	$0x6, %r12
               	je	<addr>
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
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
