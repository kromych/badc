
aio_read_write_completes.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x310, %rsp            # imm = 0x310
               	pushq	%rbx
               	leaq	0x58(%rsp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	0x10(%rax), %r10d
               	movl	%r10d, 0x10(%rdi)
               	movzbq	0x14(%rax), %r10
               	movb	%r10b, 0x14(%rdi)
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, 0x18(%rsp)
               	testl	%eax, %eax
               	jge	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0x310, %rsp            # imm = 0x310
               	retq
               	leaq	0x58(%rsp), %rdi
               	callq	<addr>
               	movq	$0x0, 0x118(%rsp)
               	movq	$0x0, 0x120(%rsp)
               	movq	$0x0, 0x128(%rsp)
               	movq	$0x0, 0x130(%rsp)
               	movq	$0x0, 0x138(%rsp)
               	movq	$0x0, 0x140(%rsp)
               	movq	$0x0, 0x148(%rsp)
               	movq	$0x0, 0x150(%rsp)
               	movq	$0x0, 0x158(%rsp)
               	movq	$0x0, 0x160(%rsp)
               	movq	$0x0, 0x168(%rsp)
               	movq	$0x0, 0x170(%rsp)
               	movq	$0x0, 0x178(%rsp)
               	movq	$0x0, 0x180(%rsp)
               	movq	$0x0, 0x188(%rsp)
               	movq	$0x0, 0x190(%rsp)
               	movq	$0x0, 0x198(%rsp)
               	movq	$0x0, 0x1a0(%rsp)
               	movq	$0x0, 0x1a8(%rsp)
               	movq	$0x0, 0x1b0(%rsp)
               	movq	$0x0, 0x1b8(%rsp)
               	movq	0x18(%rsp), %r10
               	movl	%r10d, 0x118(%rsp)
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x128(%rsp)
               	movq	$0xc, 0x130(%rsp)
               	leaq	0x118(%rsp), %rdi
               	movq	$0x0, 0x198(%rsp)
               	movl	$0x1, 0x144(%rsp)
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	addq	$0x310, %rsp            # imm = 0x310
               	retq
               	leaq	0x118(%rsp), %rbx
               	leaq	0x48(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rbx, 0x30(%rsp)
               	jmp	<addr>
               	leaq	0x30(%rsp), %rdi
               	movl	$0x1, %esi
               	leaq	0x48(%rsp), %rdx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x73, %rax
               	je	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	addq	$0x310, %rsp            # imm = 0x310
               	retq
               	movq	$0x0, 0x1c0(%rsp)
               	movq	$0x0, 0x1c8(%rsp)
               	movq	$0x0, 0x1d0(%rsp)
               	movq	$0x0, 0x1d8(%rsp)
               	movq	$0x0, 0x1e0(%rsp)
               	movq	$0x0, 0x1e8(%rsp)
               	movq	$0x0, 0x1f0(%rsp)
               	movq	$0x0, 0x1f8(%rsp)
               	movq	$0x0, 0x200(%rsp)
               	movq	$0x0, 0x208(%rsp)
               	movq	$0x0, 0x210(%rsp)
               	movq	$0x0, 0x218(%rsp)
               	movq	$0x0, 0x220(%rsp)
               	movq	$0x0, 0x228(%rsp)
               	movq	$0x0, 0x230(%rsp)
               	movq	$0x0, 0x238(%rsp)
               	movq	$0x0, 0x240(%rsp)
               	movq	$0x0, 0x248(%rsp)
               	movq	$0x0, 0x250(%rsp)
               	movq	$0x0, 0x258(%rsp)
               	movq	$0x0, 0x260(%rsp)
               	movq	0x18(%rsp), %r10
               	movl	%r10d, 0x1c0(%rsp)
               	leaq	0x20(%rsp), %rcx
               	movq	%rcx, 0x1d0(%rsp)
               	movq	$0x8, 0x1d8(%rsp)
               	leaq	0x1c0(%rsp), %rdi
               	movq	$0x0, 0x240(%rsp)
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	addq	$0x310, %rsp            # imm = 0x310
               	retq
               	leaq	0x1c0(%rsp), %rbx
               	leaq	0x48(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rbx, 0x30(%rsp)
               	jmp	<addr>
               	leaq	0x30(%rsp), %rdi
               	movl	$0x1, %esi
               	leaq	0x48(%rsp), %rdx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x73, %rax
               	je	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x8, %rax
               	jne	<addr>
               	leaq	0x20(%rsp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x8, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	addq	$0x310, %rsp            # imm = 0x310
               	retq
               	xorl	%edi, %edi
               	movq	%rdi, 0x268(%rsp)
               	movq	%rdi, 0x270(%rsp)
               	movq	%rdi, 0x278(%rsp)
               	movq	%rdi, 0x280(%rsp)
               	movq	%rdi, 0x288(%rsp)
               	movq	%rdi, 0x290(%rsp)
               	movq	%rdi, 0x298(%rsp)
               	movq	%rdi, 0x2a0(%rsp)
               	movq	%rdi, 0x2a8(%rsp)
               	movq	%rdi, 0x2b0(%rsp)
               	movq	%rdi, 0x2b8(%rsp)
               	movq	%rdi, 0x2c0(%rsp)
               	movq	%rdi, 0x2c8(%rsp)
               	movq	%rdi, 0x2d0(%rsp)
               	movq	%rdi, 0x2d8(%rsp)
               	movq	%rdi, 0x2e0(%rsp)
               	movq	%rdi, 0x2e8(%rsp)
               	movq	%rdi, 0x2f0(%rsp)
               	movq	%rdi, 0x2f8(%rsp)
               	movq	%rdi, 0x300(%rsp)
               	movq	%rdi, 0x308(%rsp)
               	movq	0x18(%rsp), %rax
               	movl	%eax, 0x268(%rsp)
               	leaq	0x28(%rsp), %rcx
               	movq	%rcx, 0x278(%rsp)
               	movq	$0x4, 0x280(%rsp)
               	leaq	0x268(%rsp), %rcx
               	movq	$0x8, 0x2e8(%rsp)
               	movl	%edi, 0x26c(%rsp)
               	leaq	0x70(%rsp), %rsi
               	movq	%rdi, 0x70(%rsp)
               	movq	%rdi, 0x78(%rsp)
               	movq	%rdi, 0x80(%rsp)
               	movq	%rdi, 0x88(%rsp)
               	movq	%rdi, 0x90(%rsp)
               	movq	%rdi, 0x98(%rsp)
               	movq	%rdi, 0xa0(%rsp)
               	movq	%rdi, 0xa8(%rsp)
               	movq	%rdi, 0xb0(%rsp)
               	movq	%rdi, 0xb8(%rsp)
               	movq	%rdi, 0xc0(%rsp)
               	movq	%rdi, 0xc8(%rsp)
               	movq	%rdi, 0xd0(%rsp)
               	movq	%rdi, 0xd8(%rsp)
               	movq	%rdi, 0xe0(%rsp)
               	movq	%rdi, 0xe8(%rsp)
               	movq	%rdi, 0xf0(%rsp)
               	movq	%rdi, 0xf8(%rsp)
               	movq	%rdi, 0x100(%rsp)
               	movq	%rdi, 0x108(%rsp)
               	movq	%rdi, 0x110(%rsp)
               	movl	%eax, 0x70(%rsp)
               	movl	$0x2, %edx
               	movl	%edx, 0x74(%rsp)
               	movq	%rcx, 0x38(%rsp)
               	movq	%rsi, 0x40(%rsp)
               	leaq	0x38(%rsp), %rsi
               	movq	%rdi, %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	addq	$0x310, %rsp            # imm = 0x310
               	retq
               	leaq	0x268(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x268(%rsp), %rdi
               	callq	<addr>
               	cmpq	$0x4, %rax
               	jne	<addr>
               	leaq	0x28(%rsp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	addq	$0x310, %rsp            # imm = 0x310
               	retq
               	movl	$0x101000, %edi         # imm = 0x101000
               	leaq	0x118(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	addq	$0x310, %rsp            # imm = 0x310
               	retq
               	leaq	0x118(%rsp), %rbx
               	leaq	0x48(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rbx, 0x30(%rsp)
               	jmp	<addr>
               	leaq	0x30(%rsp), %rdi
               	movl	$0x1, %esi
               	leaq	0x48(%rsp), %rdx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x73, %rax
               	je	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	addq	$0x310, %rsp            # imm = 0x310
               	retq
               	xorl	%esi, %esi
               	movq	0x18(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	addq	$0x310, %rsp            # imm = 0x310
               	retq
               	leaq	0x70(%rsp), %rdi
               	callq	<addr>
               	movq	0x18(%rsp), %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x310, %rsp            # imm = 0x310
               	retq
