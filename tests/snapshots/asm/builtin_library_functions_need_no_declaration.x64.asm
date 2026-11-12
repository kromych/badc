
builtin_library_functions_need_no_declaration.x64:	file format elf64-x86-64

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

<format>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xa0(%rbp)
               	movups	%xmm1, -0x90(%rbp)
               	movups	%xmm2, -0x80(%rbp)
               	movups	%xmm3, -0x70(%rbp)
               	movups	%xmm4, -0x60(%rbp)
               	movups	%xmm5, -0x50(%rbp)
               	movups	%xmm6, -0x40(%rbp)
               	movups	%xmm7, -0x30(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xc0(%rbp), %rcx
               	movl	$0x18, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	movq	-0xd0(%rbp), %rdi
               	movq	-0xc8(%rbp), %rsi
               	movq	-0xc0(%rbp), %rdx
               	leaq	-0x18(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x18(%rbp), %rcx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movl	$0xfffffff9, -0x38(%rbp) # imm = 0xFFFFFFF9
               	movq	$-0x8, -0x30(%rbp)
               	movq	$-0x9, -0x28(%rbp)
               	movabsq	$-0x3ffc000000000000, %rax # imm = 0xC004000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x20(%rbp)
               	movl	$0xbfc00000, -0x18(%rbp) # imm = 0xBFC00000
               	movabsq	$-0x3ff6000000000000, %rax # imm = 0xC00A000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x80(%rbp)
               	movslq	-0x38(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x1f, %rcx
               	xorq	%rcx, %rax
               	subq	%rcx, %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movq	-0x30(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	xorq	%rcx, %rax
               	subq	%rcx, %rax
               	cmpq	$0x8, %rax
               	jne	<addr>
               	movq	-0x28(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	xorq	%rcx, %rax
               	subq	%rcx, %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	-0x28(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	xorq	%rcx, %rax
               	subq	%rcx, %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movl	-0x38(%rbp), %eax
               	negq	%rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	sarq	$0x1f, %rcx
               	xorq	%rcx, %rax
               	subq	%rcx, %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movsd	-0x20(%rbp), %xmm0
               	movabsq	$0x7fffffffffffffff, %r10 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%r10, %xmm15
               	andpd	%xmm15, %xmm0
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x18(%rbp), %xmm0
               	movl	$0x7fffffff, %r10d      # imm = 0x7FFFFFFF
               	movq	%r10, %xmm15
               	andpd	%xmm15, %xmm0
               	movl	$0x3fc00000, %eax       # imm = 0x3FC00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	fldt	-0x80(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x7fffffffffffffff, %r10 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%r10, %xmm15
               	andpd	%xmm15, %xmm0
               	movabsq	$0x400a000000000000, %rax # imm = 0x400A000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movsd	-0x20(%rbp), %xmm0
               	movsd	-0x20(%rbp), %xmm1
               	mulsd	%xmm1, %xmm0
               	sqrtsd	%xmm0, %xmm0
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x20(%rbp), %xmm0
               	roundsd	$0x9, %xmm0, %xmm0
               	movabsq	$-0x3ff8000000000000, %rax # imm = 0xC008000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x18(%rbp), %xmm0
               	roundss	$0xa, %xmm0, %xmm0
               	movl	$0xbf800000, %eax       # imm = 0xBF800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	$0x6, -0x10(%rbp)
               	movl	$0x3, -0x8(%rbp)
               	leaq	-0x58(%rbp), %rdi
               	movl	$0x78, %esi
               	movq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x58(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x58(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x5, %rax
               	jne	<addr>
               	leaq	-0x58(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x58(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	-0x8(%rbp), %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x58(%rbp), %rdi
               	movl	$0x6c, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x58(%rbp), %rcx
               	addq	$0x2, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	-0x8(%rbp), %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	-0x8(%rbp), %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x58(%rbp), %rdi
               	movl	$0x20, %esi
               	leaq	<rip>, %rdx
               	movl	$0x2a, %ecx
               	leaq	<rip>, %r8
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x58(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movq	-0x10(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x18(%rsp), %r10
               	testq	%r10, %r10
               	jne	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	leaq	-0x58(%rbp), %rsi
               	movq	-0x10(%rbp), %rdx
               	movq	0x18(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movq	-0x10(%rbp), %rdx
               	movq	0x18(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x18(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	movl	$0xc, %ecx
               	movq	0x10(%rsp), %r10
               	testq	%r10, %r10
               	cmovneq	%rcx, %rax
               	leave
               	retq
