
sys_queue_and_timeval_macros.x64:	file format elf64-x86-64

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

<lists>:
               	subq	$0x108, %rsp            # imm = 0x108
               	leaq	0x28(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	movups	0x30(%rcx), %xmm14
               	movups	%xmm14, 0x30(%rax)
               	movups	0x40(%rcx), %xmm14
               	movups	%xmm14, 0x40(%rax)
               	movups	0x50(%rcx), %xmm14
               	movups	%xmm14, 0x50(%rax)
               	movups	0x60(%rcx), %xmm14
               	movups	%xmm14, 0x60(%rax)
               	movups	0x70(%rcx), %xmm14
               	movups	%xmm14, 0x70(%rax)
               	movups	0x80(%rcx), %xmm14
               	movups	%xmm14, 0x80(%rax)
               	movups	0x90(%rcx), %xmm14
               	movups	%xmm14, 0x90(%rax)
               	movups	0xa0(%rcx), %xmm14
               	movups	%xmm14, 0xa0(%rax)
               	movups	0xb0(%rcx), %xmm14
               	movups	%xmm14, 0xb0(%rax)
               	movups	0xc0(%rcx), %xmm14
               	movups	%xmm14, 0xc0(%rax)
               	movq	0xd0(%rcx), %r10
               	movq	%r10, 0xd0(%rax)
               	xorl	%ecx, %ecx
               	movq	%rcx, (%rsp)
               	leaq	0x8(%rsp), %rax
               	movq	%rcx, 0x8(%rsp)
               	movq	%rax, 0x10(%rsp)
               	leaq	0x18(%rsp), %rax
               	movq	%rax, 0x18(%rsp)
               	movq	%rax, 0x20(%rsp)
               	cmpq	$0x0, <rip> # <addr>
               	jne	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	leaq	0x28(%rsp), %rsi
               	addq	%rsi, %rcx
               	movq	%rcx, 0x20(%rsp)
               	incq	%rax
               	movq	%rdx, %rcx
               	cmpl	$0x3, %eax
               	jge	<addr>
               	leaq	0x28(%rsp), %rdx
               	imulq	$0x48, %rax, %rsi
               	addq	%rsi, %rdx
               	movq	%rcx, 0x8(%rdx)
               	movq	(%rsp), %rcx
               	movq	%rcx, 0x10(%rdx)
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	(%rsp), %rcx
               	leaq	0x28(%rsp), %rdi
               	addq	%rsi, %rdi
               	addq	$0x10, %rdi
               	movq	%rdi, 0x18(%rcx)
               	leaq	0x28(%rsp), %rdi
               	leaq	(%rdi,%rsi), %rcx
               	movq	%rcx, (%rsp)
               	imulq	$0x48, %rax, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	leaq	(%rsp), %rdi
               	movq	%rdi, 0x18(%rsi)
               	movq	$0x0, 0x20(%rsi)
               	movq	<rip>, %rdi # <addr>
               	leaq	0x28(%rsp), %rsi
               	addq	%rcx, %rsi
               	movq	%rsi, (%rdi)
               	addq	$0x20, %rsi
               	movq	%rsi, <rip> # <addr>
               	leaq	0x28(%rsp), %rsi
               	addq	%rsi, %rcx
               	movq	$0x0, 0x28(%rcx)
               	movq	0x10(%rsp), %rdi
               	movq	%rdi, 0x30(%rcx)
               	movq	0x10(%rsp), %rdi
               	imulq	$0x48, %rax, %rcx
               	addq	%rcx, %rsi
               	movq	%rsi, (%rdi)
               	leaq	0x28(%rsp), %rsi
               	addq	%rcx, %rsi
               	leaq	0x28(%rsi), %rdi
               	movq	%rdi, 0x10(%rsp)
               	leaq	0x18(%rsp), %rdi
               	movq	%rdi, 0x38(%rsi)
               	leaq	0x28(%rsp), %rsi
               	addq	%rcx, %rsi
               	movq	0x20(%rsp), %r8
               	movq	%r8, 0x40(%rsi)
               	movq	0x18(%rsp), %rsi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	leaq	0x28(%rsp), %rsi
               	addq	%rcx, %rsi
               	movq	%rsi, 0x18(%rsp)
               	jmp	<addr>
               	movq	0x20(%rsp), %rsi
               	leaq	0x28(%rsp), %rdi
               	imulq	$0x48, %rax, %r8
               	addq	%r8, %rdi
               	movq	%rdi, 0x38(%rsi)
               	jmp	<addr>
               	xorl	%edx, %edx
               	movq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	imulq	$0xa, %rdx, %rdx
               	movslq	(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x141, %rdx            # imm = 0x141
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x108, %rsp            # imm = 0x108
               	retq
               	xorl	%edx, %edx
               	movq	(%rsp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	imulq	$0xa, %rdx, %rdx
               	movslq	(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x10(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x141, %rdx            # imm = 0x141
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x108, %rsp            # imm = 0x108
               	retq
               	xorl	%edx, %edx
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	imulq	$0xa, %rdx, %rdx
               	movslq	(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x20(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x7b, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x108, %rsp            # imm = 0x108
               	retq
               	xorl	%edx, %edx
               	movq	0x10(%rsp), %rax
               	movq	0x8(%rax), %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	imulq	$0xa, %rdx, %rdx
               	movslq	(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x30(%rax), %rax
               	movq	0x8(%rax), %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x141, %rdx            # imm = 0x141
               	jne	<addr>
               	movq	0x10(%rsp), %rax
               	movq	0x8(%rax), %rax
               	movq	(%rax), %rdx
               	leaq	0x28(%rsp), %rax
               	leaq	0x90(%rax), %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movq	0xa0(%rsp), %rdx
               	movq	0x8(%rdx), %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x108, %rsp            # imm = 0x108
               	retq
               	xorl	%edx, %edx
               	leaq	0x18(%rsp), %rsi
               	movq	0x18(%rsp), %rax
               	cmpq	%rsi, %rax
               	je	<addr>
               	imulq	$0xa, %rdx, %rdx
               	movslq	(%rax), %rdi
               	addq	%rdi, %rdx
               	movq	0x38(%rax), %rax
               	cmpq	%rsi, %rax
               	jne	<addr>
               	cmpq	$0x7b, %rdx
               	jne	<addr>
               	movq	0x20(%rsp), %rdx
               	leaq	0x28(%rsp), %rax
               	leaq	0x90(%rax), %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x108, %rsp            # imm = 0x108
               	retq
               	leaq	0x48(%rax), %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	0x8(%rcx), %rcx
               	leaq	0x28(%rsp), %rdx
               	movq	0x80(%rsp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	0x88(%rsp), %rsi
               	movq	%rsi, 0x18(%rax)
               	movq	0x88(%rsp), %rax
               	movq	0x80(%rsp), %rsi
               	movq	%rsi, (%rax)
               	leaq	<rip>, %rsi # <addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x48, %rdx
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movq	0x20(%rax), %rax
               	movq	%rax, <rip> # <addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rsi, <rip> # <addr>
               	movq	0x98(%rsp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	0xa0(%rsp), %rdx
               	movq	%rdx, 0x30(%rax)
               	movq	0xa0(%rsp), %rax
               	movq	0x98(%rsp), %rdx
               	movq	%rdx, (%rax)
               	movq	0xa8(%rsp), %rax
               	leaq	0x18(%rsp), %rdx
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movq	0xb0(%rsp), %rax
               	movq	%rax, 0x20(%rsp)
               	movq	0xb0(%rsp), %rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movq	0xa8(%rsp), %rax
               	movq	%rax, 0x18(%rsp)
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	imulq	$0xa, %rax, %rax
               	movslq	(%rcx), %rdx
               	addq	%rdx, %rax
               	movq	0x8(%rcx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	(%rsp), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	imulq	$0xa, %rax, %rax
               	movslq	(%rcx), %rdx
               	addq	%rdx, %rax
               	movq	0x10(%rcx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	imulq	$0xa, %rax, %rax
               	movslq	(%rcx), %rdx
               	addq	%rdx, %rax
               	movq	0x20(%rcx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x8(%rsp), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	imulq	$0xa, %rax, %rax
               	movslq	(%rcx), %rdx
               	addq	%rdx, %rax
               	movq	0x28(%rcx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	0x18(%rsp), %rdx
               	movq	0x18(%rsp), %rcx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	imulq	$0xa, %rax, %rax
               	movslq	(%rcx), %rsi
               	addq	%rsi, %rax
               	movq	0x38(%rcx), %rcx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movl	$0xbaa145b1, %r11d      # imm = 0xBAA145B1
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x108, %rsp            # imm = 0x108
               	retq
               	leaq	0x28(%rsp), %rax
               	movq	0xe8(%rsp), %rcx
               	movq	%rcx, 0xa0(%rsp)
               	leaq	0x90(%rax), %rdx
               	movq	%rdx, 0x98(%rsp)
               	addq	$0x48, %rax
               	movq	%rax, (%rcx)
               	leaq	0x28(%rsp), %rax
               	leaq	0x70(%rax), %rcx
               	movq	%rcx, 0xe8(%rsp)
               	movq	0x38(%rsp), %rcx
               	movq	%rcx, 0x80(%rsp)
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	0x58(%rax), %rdx
               	movq	%rdx, 0x18(%rcx)
               	addq	$0x48, %rax
               	movq	%rax, 0x38(%rsp)
               	leaq	0x28(%rsp), %rax
               	addq	$0x10, %rax
               	movq	%rax, 0x88(%rsp)
               	xorl	%eax, %eax
               	movq	0x8(%rsp), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	imulq	$0xa, %rax, %rax
               	movslq	(%rcx), %rdx
               	addq	%rdx, %rax
               	movq	0x28(%rcx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	(%rsp), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	imulq	$0xa, %rax, %rax
               	movslq	(%rcx), %rdx
               	addq	%rdx, %rax
               	movq	0x10(%rcx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpq	$0x1e1b0, %rax          # imm = 0x1E1B0
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x108, %rsp            # imm = 0x108
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	0x20(%rax), %rax
               	movq	%rax, <rip> # <addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rcx, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	leaq	0x28(%rsp), %rcx
               	addq	$0x90, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	cmpq	$0x0, 0xd8(%rsp)
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x108, %rsp            # imm = 0x108
               	retq
               	xorl	%eax, %eax
               	addq	$0x108, %rsp            # imm = 0x108
               	retq
               	movq	0xa8(%rsp), %rdx
               	movq	%rdx, 0x38(%rax)
               	jmp	<addr>
               	movq	0xb0(%rsp), %rsi
               	movq	%rsi, 0x40(%rax)
               	jmp	<addr>
               	movq	0xa0(%rsp), %rax
               	movq	%rax, 0x10(%rsp)
               	jmp	<addr>
               	movq	%rdx, %rax
               	movq	0x20(%rax), %rdx
               	leaq	0x28(%rsp), %rsi
               	addq	$0x48, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movq	0x20(%rdx), %rdx
               	movq	%rdx, 0x20(%rax)
               	testq	%rdx, %rdx
               	jne	<addr>
               	addq	$0x20, %rax
               	movq	%rax, <rip> # <addr>
               	jmp	<addr>
               	movq	%rcx, %rsi
               	movq	0x8(%rsi), %rax
               	cmpq	%rdx, %rax
               	je	<addr>
               	movq	%rax, %rsi
               	movq	0x8(%rsi), %rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	movq	%rax, 0x8(%rsi)
               	jmp	<addr>
               	movl	$0x1, %eax
               	addq	$0x108, %rsp            # imm = 0x108
               	retq

<main>:
               	subq	$0x38, %rsp
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x10(%rsp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%ecx, %ecx
               	leaq	0x20(%rsp), %rdx
               	movq	%rcx, 0x20(%rsp)
               	movq	%rdx, 0x28(%rsp)
               	movq	%rcx, 0x8(%rsp)
               	movq	%rax, (%rdx)
               	leaq	(%rsp), %rax
               	addq	$0x8, %rax
               	movq	%rax, 0x28(%rsp)
               	leaq	0x10(%rsp), %rax
               	movq	0x20(%rsp), %rdx
               	movq	%rdx, 0x18(%rsp)
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x8(%rax), %rdx
               	movq	%rdx, 0x28(%rsp)
               	movq	%rax, 0x20(%rsp)
               	testq	%rax, %rax
               	je	<addr>
               	imulq	$0xa, %rcx, %rcx
               	movl	(%rax), %edx
               	addq	%rdx, %rcx
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x20(%rsp), %rsi
               	movq	0x20(%rsp), %rax
               	leaq	(%rsp), %rdx
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	movq	%rax, 0x20(%rsp)
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rsi, 0x28(%rsp)
               	cmpl	$0x15, %ecx
               	jne	<addr>
               	movq	0x20(%rsp), %rax
               	leaq	0x10(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	cmpq	$0x0, 0x18(%rsp)
               	jne	<addr>
               	xorl	%eax, %eax
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0xe, %eax
               	jmp	<addr>
               	movq	%rdx, %rax
               	movq	0x8(%rax), %rdx
               	leaq	(%rsp), %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movq	0x8(%rdx), %rdx
               	movq	%rdx, 0x8(%rax)
               	testq	%rdx, %rdx
               	jne	<addr>
               	addq	$0x8, %rax
               	movq	%rax, 0x28(%rsp)
               	jmp	<addr>
