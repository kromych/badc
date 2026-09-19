
c11_atomic_ops.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	movl	$0x64, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %ecx
               	xorq	$0x64, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0xfa, %ecx
               	movq	%rcx, %r10
               	xchgl	%r10d, (%rax)
               	movl	(%rax), %ecx
               	xorq	$0xfa, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x5, %ecx
               	pushq	%rax
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	movq	%r10, %rax
               	lock
               	xaddl	%eax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rdx
               	xorq	$0xfa, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	-0x8(%rbp), %edx
               	xorq	$0xff, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x32, %edx
               	pushq	%rax
               	movq	%rax, %r11
               	movq	%rdx, %r10
               	movq	%r10, %rax
               	negq	%rax
               	lock
               	xaddl	%eax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rdx
               	xorq	$0xff, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movq	%rcx, %rax
               	leave
               	retq
               	movl	-0x8(%rbp), %edx
               	xorq	$0xcd, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0xf00, %edx            # imm = 0xF00
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r11
               	movq	%rdx, %r10
               	movl	(%r11), %eax
               	movq	%rax, %rcx
               	orq	%r10, %rcx
               	lock
               	cmpxchgl	%ecx, (%r11)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rdx
               	xorq	$0xcd, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	-0x8(%rbp), %edx
               	xorq	$0xfcd, %rdx            # imm = 0xFCD
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0xff, %edx
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r11
               	movq	%rdx, %r10
               	movl	(%r11), %eax
               	movq	%rax, %rcx
               	andq	%r10, %rcx
               	lock
               	cmpxchgl	%ecx, (%r11)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rax
               	xorq	$0xfcd, %rax            # imm = 0xFCD
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	-0x8(%rbp), %eax
               	xorq	$0xcd, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0xf, %esi
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r11
               	movq	%rsi, %r10
               	movl	(%r11), %eax
               	movq	%rax, %rcx
               	xorq	%r10, %rcx
               	lock
               	cmpxchgl	%ecx, (%r11)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rdx
               	xorq	$0xcd, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movl	-0x8(%rbp), %edx
               	xorq	$0xc2, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movl	$0x7, %edi
               	movq	%rax, %r11
               	movq	%rdi, %r10
               	xchgl	%r10d, (%r11)
               	movq	%r10, %rdx
               	cmpl	$0xc2, %edx
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movl	-0x8(%rbp), %edx
               	xorq	$0x7, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movl	%edi, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movl	$0x63, %edi
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r11
               	movq	%rdi, %r10
               	movq	%rdx, %rcx
               	movl	(%rcx), %eax
               	lock
               	cmpxchgl	%r10d, (%r11)
               	je	<addr>
               	movl	%eax, (%rcx)
               	sete	%r11b
               	movzbq	%r11b, %r11
               	popq	%rcx
               	popq	%rax
               	movq	%r11, %rdx
               	cmpq	$0x1, %rdx
               	je	<addr>
               	movq	%rsi, %rax
               	leave
               	retq
               	movl	-0x8(%rbp), %edx
               	xorq	$0x63, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	movl	%ecx, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	movl	$0x4d2, %edx            # imm = 0x4D2
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r11
               	movq	%rdx, %r10
               	movl	(%rcx), %eax
               	lock
               	cmpxchgl	%r10d, (%r11)
               	je	<addr>
               	movl	%eax, (%rcx)
               	sete	%r11b
               	movzbq	%r11b, %r11
               	popq	%rcx
               	popq	%rax
               	movq	%r11, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movl	-0x8(%rbp), %eax
               	xorq	$0x63, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	movl	-0x18(%rbp), %eax
               	xorq	$0x63, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	movl	$0xc8, %eax
               	movb	%al, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x64, %ecx
               	pushq	%rax
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	movq	%r10, %rax
               	lock
               	xaddb	%al, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rax
               	andq	$0xff, %rax
               	xorq	$0xc8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	movzbq	-0x20(%rbp), %rax
               	cmpl	$0x2c, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movl	$0x9c40, %eax           # imm = 0x9C40
               	movw	%ax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movl	$0x7530, %ecx           # imm = 0x7530
               	pushq	%rax
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	movq	%r10, %rax
               	lock
               	xaddw	%ax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	$0x9c40, %rax           # imm = 0x9C40
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	movzwq	-0x28(%rbp), %rax
               	cmpl	$0x1170, %eax           # imm = 0x1170
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	movabsq	$0x1122334455667788, %rax # imm = 0x1122334455667788
               	movq	%rax, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rax
               	movl	$0x1, %ecx
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	xchgq	%r10, (%r11)
               	movq	%r10, %rax
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	movq	-0x30(%rbp), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
