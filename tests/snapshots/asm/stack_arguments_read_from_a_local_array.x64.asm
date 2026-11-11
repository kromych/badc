
stack_arguments_read_from_a_local_array.x64:	file format elf64-x86-64

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

<sum_weighted>:
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
               	xorl	%eax, %eax
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0xd0(%rbp), %rdx
               	movl	$0x8, (%rcx)
               	movl	$0x30, 0x4(%rcx)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rcx)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rcx)
               	movq	%rax, %rcx
               	movl	-0xd0(%rbp), %edx
               	cmpl	%edx, %eax
               	jge	<addr>
               	leaq	0x1(%rax), %rdx
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rsi
               	movq	(%rsi), %rsi
               	imulq	%rsi, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	movl	-0xd0(%rbp), %edx
               	cmpl	%edx, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	movq	%rcx, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movl	$0x14, %eax
               	xorl	%ecx, %ecx
               	testl	%edi, %edi
               	cmovgq	%rax, %rcx
               	xorl	%eax, %eax
               	cmpl	%ecx, %eax
               	jge	<addr>
               	leaq	-0xa0(%rbp), %rdx
               	leaq	(%rax,%rax,2), %rsi
               	incq	%rsi
               	movslq	%esi, %rsi
               	movq	%rsi, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movq	-0xa0(%rbp), %rax
               	movq	$0x3e8, -0xa0(%rbp)     # imm = 0x3E8
               	movl	$0x15, %edi
               	movq	-0x98(%rbp), %rsi
               	movq	-0x90(%rbp), %rdx
               	movq	-0x88(%rbp), %rcx
               	movq	-0x80(%rbp), %r8
               	movq	-0x78(%rbp), %r9
               	subq	$0x80, %rsp
               	movq	-0x70(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	-0x68(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	-0x60(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	-0x58(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	-0x50(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	-0x48(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	-0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	-0x38(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x30(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	-0x28(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	-0x20(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	-0x18(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	-0x10(%rbp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	-0x8(%rbp), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	%rax, 0x70(%rsp)
               	movq	-0xa0(%rbp), %r10
               	movq	%r10, 0x78(%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x80, %rsp
               	xorl	%edx, %edx
               	movl	$0x1, %ecx
               	leaq	(%rcx,%rcx,2), %rsi
               	incq	%rsi
               	movslq	%esi, %rsi
               	imulq	%rcx, %rsi
               	addq	%rsi, %rdx
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	leaq	0x521c(%rdx), %rcx
               	xorl	%edx, %edx
               	movl	$0x1, %esi
               	cmpq	%rcx, %rax
               	movq	%rsi, %rax
               	cmoveq	%rdx, %rax
               	leave
               	retq
