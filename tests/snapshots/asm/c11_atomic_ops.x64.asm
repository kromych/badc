
c11_atomic_ops.x64:	file format elf64-x86-64

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
               	movl	$0x64, (%rsp)
               	leaq	(%rsp), %rcx
               	movl	(%rcx), %eax
               	cmpl	$0x64, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0xfa, %eax
               	movq	%rax, %r10
               	xchgl	%r10d, (%rcx)
               	movl	(%rcx), %eax
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x5, %edx
               	movq	%rdx, %rax
               	lock
               	xaddl	%eax, (%rcx)
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	(%rsp), %eax
               	cmpl	$0xff, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x32, %eax
               	negq	%rax
               	lock
               	xaddl	%eax, (%rcx)
               	cmpl	$0xff, %eax
               	je	<addr>
               	movq	%rdx, %rax
               	addq	$0x28, %rsp
               	retq
               	movl	(%rsp), %eax
               	cmpl	$0xcd, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0xf00, %esi            # imm = 0xF00
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0xcd, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	(%rsp), %eax
               	cmpl	$0xfcd, %eax            # imm = 0xFCD
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0xff, %esi
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0xfcd, %eax            # imm = 0xFCD
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	(%rsp), %eax
               	cmpl	$0xcd, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0xf, %esi
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0xcd, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	(%rsp), %eax
               	cmpl	$0xc2, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x7, %eax
               	movq	%rax, %rdi
               	xchgl	%edi, (%rcx)
               	cmpl	$0xc2, %edi
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	(%rsp), %ecx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	(%rsp), %rcx
               	movl	$0x63, %edi
               	movl	%eax, %eax
               	lock
               	cmpxchgl	%edi, (%rcx)
               	cmpl	$0x7, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movq	%rsi, %rax
               	addq	$0x28, %rsp
               	retq
               	movl	(%rsp), %eax
               	cmpl	$0x63, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x4d2, %esi            # imm = 0x4D2
               	movl	%edx, %eax
               	lock
               	cmpxchgl	%esi, (%rcx)
               	cmpl	$0x5, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	cmovneq	%rdx, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	(%rsp), %ecx
               	cmpl	$0x63, %ecx
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x28, %rsp
               	retq
               	cmpl	$0x63, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x28, %rsp
               	retq
               	movb	$-0x38, 0x8(%rsp)
               	leaq	0x8(%rsp), %rcx
               	movl	$0x64, %eax
               	lock
               	xaddb	%al, (%rcx)
               	andq	$0xff, %rax
               	cmpl	$0xc8, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x28, %rsp
               	retq
               	movzbq	0x8(%rsp), %rax
               	cmpl	$0x2c, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x28, %rsp
               	retq
               	movw	$0x9c40, 0x10(%rsp)     # imm = 0x9C40
               	leaq	0x10(%rsp), %rcx
               	movl	$0x7530, %eax           # imm = 0x7530
               	lock
               	xaddw	%ax, (%rcx)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0x9c40, %eax           # imm = 0x9C40
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x28, %rsp
               	retq
               	movzwq	0x10(%rsp), %rax
               	cmpl	$0x1170, %eax           # imm = 0x1170
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x28, %rsp
               	retq
               	movabsq	$0x1122334455667788, %rax # imm = 0x1122334455667788
               	movq	%rax, 0x18(%rsp)
               	leaq	0x18(%rsp), %rax
               	movl	$0x1, %ecx
               	xchgq	%rcx, (%rax)
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x18, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	0x18(%rsp), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
