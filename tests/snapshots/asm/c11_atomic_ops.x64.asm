
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
               	subq	$0x20, %rsp
               	movl	$0x64, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	movl	(%rcx), %eax
               	xorq	$0x64, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0xfa, %eax
               	movq	%rax, %r10
               	xchgl	%r10d, (%rcx)
               	movl	(%rcx), %eax
               	xorq	$0xfa, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x5, %edx
               	movq	%rdx, %rax
               	lock
               	xaddl	%eax, (%rcx)
               	xorq	$0xfa, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	-0x20(%rbp), %eax
               	xorq	$0xff, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x32, %eax
               	negq	%rax
               	lock
               	xaddl	%eax, (%rcx)
               	xorq	$0xff, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movq	%rdx, %rax
               	leave
               	retq
               	movl	-0x20(%rbp), %eax
               	xorq	$0xcd, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0xf00, %esi            # imm = 0xF00
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	xorq	$0xcd, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	-0x20(%rbp), %eax
               	xorq	$0xfcd, %rax            # imm = 0xFCD
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0xff, %esi
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	xorq	$0xfcd, %rax            # imm = 0xFCD
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	-0x20(%rbp), %eax
               	xorq	$0xcd, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rcx
               	movl	$0xf, %esi
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	xorq	$0xcd, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movl	-0x20(%rbp), %eax
               	xorq	$0xc2, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movl	$0x7, %eax
               	movq	%rax, %rdi
               	xchgl	%edi, (%rcx)
               	cmpl	$0xc2, %edi
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movl	-0x20(%rbp), %edi
               	xorq	$0x7, %rdi
               	testl	%edi, %edi
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
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
               	leave
               	retq
               	movl	-0x20(%rbp), %eax
               	xorq	$0x63, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	movl	$0x4d2, %esi            # imm = 0x4D2
               	movl	%edx, %eax
               	lock
               	cmpxchgl	%esi, (%rcx)
               	cmpl	$0x5, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movl	-0x20(%rbp), %eax
               	xorq	$0x63, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	movq	%rdx, %rax
               	xorq	$0x63, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	movb	$-0x38, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x64, %ecx
               	lock
               	xaddb	%cl, (%rax)
               	movq	%rcx, %rax
               	andq	$0xff, %rax
               	xorq	$0xc8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	movzbq	-0x18(%rbp), %rax
               	cmpl	$0x2c, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movw	$0x9c40, -0x10(%rbp)    # imm = 0x9C40
               	leaq	-0x10(%rbp), %rax
               	movl	$0x7530, %ecx           # imm = 0x7530
               	lock
               	xaddw	%cx, (%rax)
               	movq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	$0x9c40, %rax           # imm = 0x9C40
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	movzwq	-0x10(%rbp), %rax
               	cmpl	$0x1170, %eax           # imm = 0x1170
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	movabsq	$0x1122334455667788, %rax # imm = 0x1122334455667788
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x1, %ecx
               	xchgq	%rcx, (%rax)
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movq	%rax, %rdx
               	jmp	<addr>
