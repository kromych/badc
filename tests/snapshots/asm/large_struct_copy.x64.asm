
large_struct_copy.x64:	file format elf64-x86-64

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
               	subq	$0x428, %rsp            # imm = 0x428
               	movabsq	$0xc800000064, %rax     # imm = 0xC800000064
               	movq	%rax, (%rsp)
               	movabsq	$0x1900000012c, %rax    # imm = 0x1900000012C
               	movq	%rax, 0x8(%rsp)
               	movl	$0xffffffff, 0xb0(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xfffffffe, 0x154(%rsp) # imm = 0xFFFFFFFE
               	movabsq	$0x1f4fffffffd, %rax    # imm = 0x1F4FFFFFFFD
               	leaq	(%rsp), %rsi
               	movq	%rax, 0x1f8(%rsp)
               	movabsq	$0x2bc00000258, %rax    # imm = 0x2BC00000258
               	movq	%rax, 0x200(%rsp)
               	movl	$0x320, 0x208(%rsp)     # imm = 0x320
               	xorl	%eax, %eax
               	leaq	0x10(%rsi), %rcx
               	leaq	0xb4(%rsi), %rdx
               	addq	$0x158, %rsi            # imm = 0x158
               	leaq	0x3e8(%rax), %rdi
               	movl	%edi, (%rcx,%rax,4)
               	leaq	0x7d0(%rax), %rdi
               	movl	%edi, (%rdx,%rax,4)
               	leaq	0xbb8(%rax), %rdi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x28, %eax
               	jl	<addr>
               	leaq	0x210(%rsp), %rdi
               	movl	$0x7e, %esi
               	movl	$0x20c, %edx            # imm = 0x20C
               	callq	<addr>
               	leaq	0x210(%rsp), %rax
               	leaq	(%rsp), %rcx
               	leaq	0x200(%rcx), %r11
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	addq	$0x10, %rcx
               	addq	$0x10, %rax
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movl	0x8(%rcx), %r10d
               	movl	%r10d, 0x8(%rax)
               	movl	(%rsp), %eax
               	cmpl	$0x64, %eax
               	jne	<addr>
               	movl	0x4(%rsp), %eax
               	cmpl	$0xc8, %eax
               	jne	<addr>
               	movl	0x8(%rsp), %eax
               	cmpl	$0x12c, %eax            # imm = 0x12C
               	jne	<addr>
               	movl	0xc(%rsp), %eax
               	cmpl	$0x190, %eax            # imm = 0x190
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x428, %rsp            # imm = 0x428
               	retq
               	movl	0x1fc(%rsp), %eax
               	cmpl	$0x1f4, %eax            # imm = 0x1F4
               	jne	<addr>
               	movl	0x200(%rsp), %eax
               	cmpl	$0x258, %eax            # imm = 0x258
               	jne	<addr>
               	leaq	0x210(%rsp), %rcx
               	movl	0x204(%rsp), %eax
               	cmpl	$0x2bc, %eax            # imm = 0x2BC
               	jne	<addr>
               	movl	0x208(%rsp), %eax
               	cmpl	$0x320, %eax            # imm = 0x320
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x428, %rsp            # imm = 0x428
               	retq
               	movl	0xb0(%rsp), %eax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x428, %rsp            # imm = 0x428
               	retq
               	movl	0x154(%rsp), %eax
               	cmpl	$-0x2, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x428, %rsp            # imm = 0x428
               	retq
               	movl	0x1f8(%rsp), %eax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x428, %rsp            # imm = 0x428
               	retq
               	xorl	%eax, %eax
               	leaq	0x10(%rcx), %rdx
               	leaq	0xb4(%rcx), %rsi
               	addq	$0x158, %rcx            # imm = 0x158
               	movl	(%rdx,%rax,4), %edi
               	leaq	0x3e8(%rax), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	movl	(%rsi,%rax,4), %edi
               	leaq	0x7d0(%rax), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	movl	(%rcx,%rax,4), %edi
               	leaq	0xbb8(%rax), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x28, %eax
               	jl	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	addq	$0x428, %rsp            # imm = 0x428
               	retq
               	addq	$0x6e, %rax
               	addq	$0x428, %rsp            # imm = 0x428
               	retq
               	addq	$0x3c, %rax
               	addq	$0x428, %rsp            # imm = 0x428
               	retq
               	addq	$0xa, %rax
               	addq	$0x428, %rsp            # imm = 0x428
               	retq
