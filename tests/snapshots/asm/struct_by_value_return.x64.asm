
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movslq	%edi, %r11
               	movl	$0xdead, %r9d           # imm = 0xDEAD
               	movl	$0xbeef, %r8d           # imm = 0xBEEF
               	movl	$0xcafe, %edi           # imm = 0xCAFE
               	movl	$0xfacef, %esi          # imm = 0xFACEF
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	addq	%rdi, %r9
               	movslq	%r9d, %r9
               	addq	%rsi, %r9
               	movslq	%r9d, %r9
               	addq	%r11, %r9
               	movslq	%r9d, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
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
               	leaq	-0x10(%rbp), %r11
               	movq	0x30(%rbp), %r9
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r11)
               	popq	%rax
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
               	subq	$0x120, %rsp            # imm = 0x120
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	-0x8(%rbp), %rbx
               	leaq	-0x90(%rbp), %rdi
               	movl	$0xb, %esi
               	movl	$0x16, %edx
               	callq	<addr>
               	leaq	-0x90(%rbp), %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rbx)
               	popq	%r11
               	movl	$0x7, %ebx
               	movl	$0xdead, %eax           # imm = 0xDEAD
               	movl	$0xbeef, %esi           # imm = 0xBEEF
               	movl	$0xcafe, %edi           # imm = 0xCAFE
               	movl	$0xfacef, %r8d          # imm = 0xFACEF
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	addq	%r8, %rax
               	movslq	%eax, %rax
               	addq	%rbx, %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x63, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0x2, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r12
               	leaq	-0xa0(%rbp), %rdi
               	movl	$0x3, %esi
               	movl	$0x4, %edx
               	callq	<addr>
               	leaq	-0xa0(%rbp), %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r12)
               	popq	%r11
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
               	addq	$0x120, %rsp            # imm = 0x120
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
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %r14
               	leaq	-0xb0(%rbp), %rdi
               	movl	$0x64, %esi
               	movl	$0xc8, %edx
               	callq	<addr>
               	leaq	-0xb0(%rbp), %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r14)
               	popq	%r11
               	leaq	-0x38(%rbp), %r12
               	leaq	-0xc0(%rbp), %rdi
               	movl	$0x12c, %esi            # imm = 0x12C
               	movl	$0x190, %edx            # imm = 0x190
               	callq	<addr>
               	leaq	-0xc0(%rbp), %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r12)
               	popq	%r11
               	leaq	-0x30(%rbp), %r12
               	movslq	(%r12), %r12
               	cmpq	$0x64, %r12
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %r12
               	addq	$0x4, %r12
               	movslq	(%r12), %r12
               	cmpq	$0xc8, %r12
               	je	<addr>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %r12
               	movslq	(%r12), %r12
               	cmpq	$0x12c, %r12            # imm = 0x12C
               	je	<addr>
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %r12
               	addq	$0x4, %r12
               	movslq	(%r12), %r12
               	cmpq	$0x190, %r12            # imm = 0x190
               	je	<addr>
               	movl	$0x8, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %r14
               	leaq	-0xd0(%rbp), %r12
               	leaq	-0xe0(%rbp), %rdi
               	movl	$0x1, %esi
               	movl	$0x2, %edx
               	callq	<addr>
               	leaq	-0xe0(%rbp), %r15
               	leaq	-0xf0(%rbp), %rdi
               	movl	$0x3, %esi
               	movl	$0x4, %edx
               	callq	<addr>
               	leaq	-0xf0(%rbp), %rdx
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	callq	<addr>
               	leaq	-0xd0(%rbp), %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r14)
               	popq	%r11
               	leaq	-0x50(%rbp), %r14
               	movslq	(%r14), %r14
               	cmpq	$0x4, %r14
               	je	<addr>
               	movl	$0x9, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %r14
               	addq	$0x4, %r14
               	movslq	(%r14), %r14
               	cmpq	$0x6, %r14
               	je	<addr>
               	movl	$0xa, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
