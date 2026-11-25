
strength_reduce_pow2_divmod.x64:	file format elf64-x86-64

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
               	subq	$0x28, %rsp
               	movl	$0xfffffff9, (%rsp)     # imm = 0xFFFFFFF9
               	movslq	(%rsp), %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	sarq	%rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movslq	(%rsp), %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	andq	$0x1, %rax
               	subq	%rcx, %rax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0xfffffff0, (%rsp)     # imm = 0xFFFFFFF0
               	movslq	(%rsp), %rax
               	movq	%rax, %rcx
               	shrq	$0x3c, %rcx
               	addq	%rcx, %rax
               	sarq	$0x4, %rax
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	movslq	(%rsp), %rax
               	movq	%rax, %rcx
               	shrq	$0x3c, %rcx
               	addq	%rcx, %rax
               	andq	$0xf, %rax
               	subq	%rcx, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0xffffffef, (%rsp)     # imm = 0xFFFFFFEF
               	movslq	(%rsp), %rax
               	movq	%rax, %rcx
               	shrq	$0x3c, %rcx
               	addq	%rcx, %rax
               	sarq	$0x4, %rax
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	movslq	(%rsp), %rax
               	movq	%rax, %rcx
               	shrq	$0x3c, %rcx
               	addq	%rcx, %rax
               	andq	$0xf, %rax
               	subq	%rcx, %rax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x64, (%rsp)
               	movslq	(%rsp), %rax
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rcx, %rax
               	sarq	$0x3, %rax
               	cmpl	$0xc, %eax
               	jne	<addr>
               	movslq	(%rsp), %rax
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rcx, %rax
               	andq	$0x7, %rax
               	subq	%rcx, %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x80000000, (%rsp)     # imm = 0x80000000
               	movslq	(%rsp), %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	sarq	%rax
               	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
               	jne	<addr>
               	movslq	(%rsp), %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	andq	$0x1, %rax
               	subq	%rcx, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0xffffffff, 0x8(%rsp)  # imm = 0xFFFFFFFF
               	movl	0x8(%rsp), %eax
               	shrq	%rax
               	cmpl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
               	jne	<addr>
               	movl	0x8(%rsp), %eax
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x80000000, 0x8(%rsp)  # imm = 0x80000000
               	movl	0x8(%rsp), %eax
               	shrq	$0x4, %rax
               	cmpl	$0x8000000, %eax        # imm = 0x8000000
               	jne	<addr>
               	movl	0x8(%rsp), %eax
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	$-0x12d687, 0x10(%rsp)  # imm = 0xFFED2979
               	movq	0x10(%rsp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x36, %rcx
               	addq	%rcx, %rax
               	sarq	$0xa, %rax
               	cmpq	$-0x4b5, %rax           # imm = 0xFB4B
               	jne	<addr>
               	movq	0x10(%rsp), %rcx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	shrq	$0x36, %rax
               	addq	%rax, %rcx
               	andq	$0x3ff, %rcx            # imm = 0x3FF
               	subq	%rax, %rcx
               	cmpl	$0xfffffd79, %ecx       # imm = 0xFFFFFD79
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x28, %rsp
               	retq
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, 0x10(%rsp)
               	movq	0x10(%rsp), %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	sarq	%rax
               	movabsq	$-0x4000000000000000, %r11 # imm = 0xC000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	0x10(%rsp), %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	andq	$0x1, %rax
               	subq	%rcx, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	$-0x1, 0x18(%rsp)
               	movq	0x18(%rsp), %rax
               	shrq	%rax
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	0x18(%rsp), %rax
               	andq	$0xff, %rax
               	cmpl	$0xff, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0xfffffffb, (%rsp)     # imm = 0xFFFFFFFB
               	movl	(%rsp), %eax
               	cmpl	$-0x5, %eax
               	jne	<addr>
               	movl	(%rsp), %eax
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0xb, %eax
               	addq	$0x28, %rsp
               	retq
