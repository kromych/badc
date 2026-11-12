
aio_read_write_completes.x64:	file format elf64-x86-64

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
               	subq	$0x308, %rsp            # imm = 0x308
               	pushq	%rbx
               	leaq	-0x2b8(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	0x10(%rax), %r10d
               	movl	%r10d, 0x10(%rdi)
               	movzbq	0x14(%rax), %r10
               	movb	%r10b, 0x14(%rdi)
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x18(%rsp), %rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x2b8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	$0x0, -0x1f8(%rbp)
               	movq	$0x0, -0x1f0(%rbp)
               	movq	$0x0, -0x1e8(%rbp)
               	movq	$0x0, -0x1e0(%rbp)
               	movq	$0x0, -0x1d8(%rbp)
               	movq	$0x0, -0x1d0(%rbp)
               	movq	$0x0, -0x1c8(%rbp)
               	movq	$0x0, -0x1c0(%rbp)
               	movq	$0x0, -0x1b8(%rbp)
               	movq	$0x0, -0x1b0(%rbp)
               	movq	$0x0, -0x1a8(%rbp)
               	movq	$0x0, -0x1a0(%rbp)
               	movq	$0x0, -0x198(%rbp)
               	movq	$0x0, -0x190(%rbp)
               	movq	$0x0, -0x188(%rbp)
               	movq	$0x0, -0x180(%rbp)
               	movq	$0x0, -0x178(%rbp)
               	movq	$0x0, -0x170(%rbp)
               	movq	$0x0, -0x168(%rbp)
               	movq	$0x0, -0x160(%rbp)
               	movq	$0x0, -0x158(%rbp)
               	movq	0x18(%rsp), %r10
               	movl	%r10d, -0x1f8(%rbp)
               	leaq	<rip>, %rcx
               	movq	%rcx, -0x1e8(%rbp)
               	movq	$0xc, -0x1e0(%rbp)
               	leaq	-0x1f8(%rbp), %rdi
               	movq	$0x0, -0x178(%rbp)
               	movl	$0x1, -0x1cc(%rbp)
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x1f8(%rbp), %rbx
               	leaq	-0x2c8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rbx, -0x2e0(%rbp)
               	jmp	<addr>
               	leaq	-0x2e0(%rbp), %rdi
               	movl	$0x1, %esi
               	leaq	-0x2c8(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x73, %rax
               	je	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$0x0, -0x150(%rbp)
               	movq	$0x0, -0x148(%rbp)
               	movq	$0x0, -0x140(%rbp)
               	movq	$0x0, -0x138(%rbp)
               	movq	$0x0, -0x130(%rbp)
               	movq	$0x0, -0x128(%rbp)
               	movq	$0x0, -0x120(%rbp)
               	movq	$0x0, -0x118(%rbp)
               	movq	$0x0, -0x110(%rbp)
               	movq	$0x0, -0x108(%rbp)
               	movq	$0x0, -0x100(%rbp)
               	movq	$0x0, -0xf8(%rbp)
               	movq	$0x0, -0xf0(%rbp)
               	movq	$0x0, -0xe8(%rbp)
               	movq	$0x0, -0xe0(%rbp)
               	movq	$0x0, -0xd8(%rbp)
               	movq	$0x0, -0xd0(%rbp)
               	movq	$0x0, -0xc8(%rbp)
               	movq	$0x0, -0xc0(%rbp)
               	movq	$0x0, -0xb8(%rbp)
               	movq	$0x0, -0xb0(%rbp)
               	movq	0x18(%rsp), %r10
               	movl	%r10d, -0x150(%rbp)
               	leaq	-0x2f0(%rbp), %rcx
               	movq	%rcx, -0x140(%rbp)
               	movq	$0x8, -0x138(%rbp)
               	leaq	-0x150(%rbp), %rdi
               	movq	$0x0, -0xd0(%rbp)
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x150(%rbp), %rbx
               	leaq	-0x2c8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rbx, -0x2e0(%rbp)
               	jmp	<addr>
               	leaq	-0x2e0(%rbp), %rdi
               	movl	$0x1, %esi
               	leaq	-0x2c8(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x73, %rax
               	je	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x8, %rax
               	jne	<addr>
               	leaq	-0x2f0(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	movq	%rdi, -0xa8(%rbp)
               	movq	%rdi, -0xa0(%rbp)
               	movq	%rdi, -0x98(%rbp)
               	movq	%rdi, -0x90(%rbp)
               	movq	%rdi, -0x88(%rbp)
               	movq	%rdi, -0x80(%rbp)
               	movq	%rdi, -0x78(%rbp)
               	movq	%rdi, -0x70(%rbp)
               	movq	%rdi, -0x68(%rbp)
               	movq	%rdi, -0x60(%rbp)
               	movq	%rdi, -0x58(%rbp)
               	movq	%rdi, -0x50(%rbp)
               	movq	%rdi, -0x48(%rbp)
               	movq	%rdi, -0x40(%rbp)
               	movq	%rdi, -0x38(%rbp)
               	movq	%rdi, -0x30(%rbp)
               	movq	%rdi, -0x28(%rbp)
               	movq	%rdi, -0x20(%rbp)
               	movq	%rdi, -0x18(%rbp)
               	movq	%rdi, -0x10(%rbp)
               	movq	%rdi, -0x8(%rbp)
               	movq	0x18(%rsp), %rax
               	movl	%eax, -0xa8(%rbp)
               	leaq	-0x2e8(%rbp), %rcx
               	movq	%rcx, -0x98(%rbp)
               	movq	$0x4, -0x90(%rbp)
               	leaq	-0xa8(%rbp), %rcx
               	movq	$0x8, -0x28(%rbp)
               	movl	%edi, -0xa4(%rbp)
               	leaq	-0x2a0(%rbp), %rsi
               	movq	%rdi, -0x2a0(%rbp)
               	movq	%rdi, -0x298(%rbp)
               	movq	%rdi, -0x290(%rbp)
               	movq	%rdi, -0x288(%rbp)
               	movq	%rdi, -0x280(%rbp)
               	movq	%rdi, -0x278(%rbp)
               	movq	%rdi, -0x270(%rbp)
               	movq	%rdi, -0x268(%rbp)
               	movq	%rdi, -0x260(%rbp)
               	movq	%rdi, -0x258(%rbp)
               	movq	%rdi, -0x250(%rbp)
               	movq	%rdi, -0x248(%rbp)
               	movq	%rdi, -0x240(%rbp)
               	movq	%rdi, -0x238(%rbp)
               	movq	%rdi, -0x230(%rbp)
               	movq	%rdi, -0x228(%rbp)
               	movq	%rdi, -0x220(%rbp)
               	movq	%rdi, -0x218(%rbp)
               	movq	%rdi, -0x210(%rbp)
               	movq	%rdi, -0x208(%rbp)
               	movq	%rdi, -0x200(%rbp)
               	movl	%eax, -0x2a0(%rbp)
               	movl	$0x2, %edx
               	movl	%edx, -0x29c(%rbp)
               	movq	%rcx, -0x2d8(%rbp)
               	movq	%rsi, -0x2d0(%rbp)
               	leaq	-0x2d8(%rbp), %rsi
               	movq	%rdi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xa8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x4, %rax
               	jne	<addr>
               	leaq	-0x2e8(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x101000, %edi         # imm = 0x101000
               	leaq	-0x1f8(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x1f8(%rbp), %rbx
               	leaq	-0x2c8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rbx, -0x2e0(%rbp)
               	jmp	<addr>
               	leaq	-0x2e0(%rbp), %rdi
               	movl	$0x1, %esi
               	leaq	-0x2c8(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x73, %rax
               	je	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%esi, %esi
               	movq	0x18(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x2a0(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	0x18(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
