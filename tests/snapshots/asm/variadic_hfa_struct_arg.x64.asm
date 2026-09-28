
variadic_hfa_struct_arg.x64:	file format elf64-x86-64

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

<sum>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	movq	%rdi, -0xf0(%rbp)
               	movq	%rsi, -0xe8(%rbp)
               	movq	%rdx, -0xe0(%rbp)
               	movq	%rcx, -0xd8(%rbp)
               	movq	%r8, -0xd0(%rbp)
               	movq	%r9, -0xc8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xc0(%rbp)
               	movups	%xmm1, -0xb0(%rbp)
               	movups	%xmm2, -0xa0(%rbp)
               	movups	%xmm3, -0x90(%rbp)
               	movups	%xmm4, -0x80(%rbp)
               	movups	%xmm5, -0x70(%rbp)
               	movups	%xmm6, -0x60(%rbp)
               	movups	%xmm7, -0x50(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xf0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xf0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x38(%rbp), %rcx
               	movq	%rax, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0x90, %r10
               	ja	<addr>
               	pushq	%rax
               	movl	0x4(%r11), %r10d
               	addq	0x10(%r11), %r10
               	movq	(%r10), %r10
               	movq	%r10, (%rcx)
               	addl	$0x10, 0x4(%r11)
               	movl	0x4(%r11), %r10d
               	addq	0x10(%r11), %r10
               	movq	(%r10), %r10
               	movq	%r10, 0x8(%rcx)
               	addl	$0x10, 0x4(%r11)
               	movq	%rcx, %r10
               	popq	%rax
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x10, 0x8(%r11)
               	movq	%r10, %rax
               	leaq	-0x28(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x28(%rbp), %rax
               	movsd	(%rax), %xmm0
               	movsd	0x8(%rax), %xmm1
               	addsd	%xmm1, %xmm0
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %r9
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, (%r9)
               	movabsq	$0x4002000000000000, %rax # imm = 0x4002000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0x8(%r9)
               	movl	$0x1, %edi
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movsd	0x8(%r10), %xmm1
               	movb	$0x2, %al
               	callq	<addr>
               	movabsq	$0x400e000000000000, %rax # imm = 0x400E000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
