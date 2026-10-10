
call_result_into_member.x64:	file format elf64-x86-64

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

<keep>:
               	leaq	<rip>, %rax      # <addr>
               	movq	%rdi, (%rax)
               	retq

<mk_U1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movb	$0x0, (%rax)
               	movq	%rdi, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x8(%rbp)
               	movq	%rax, %rcx
               	movzbq	(%rcx), %rax
               	leave
               	retq

<mk_U2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movw	$0x0, (%rax)
               	movq	%rdi, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, -0x8(%rbp)
               	movq	%rax, %rcx
               	movzwq	(%rcx), %rax
               	leave
               	retq

<mk_U3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movw	$0x0, (%rax)
               	movb	$0x0, 0x2(%rax)
               	movq	%rdi, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x8(%rbp)
               	movb	$0x2, -0x7(%rbp)
               	movb	$0x3, -0x6(%rbp)
               	movq	%rax, %rcx
               	movzwq	(%rcx), %rax
               	movzbq	0x2(%rcx), %r10
               	shlq	$0x10, %r10
               	orq	%r10, %rax
               	leave
               	retq

<mk_B4>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movl	$0x0, (%rax)
               	movq	%rdi, %rcx
               	andq	$0xfffff, %rcx          # imm = 0xFFFFF
               	movl	%ecx, -0x8(%rbp)
               	movl	-0x8(%rbp), %ecx
               	andq	$-0x3ff00001, %rcx      # imm = 0xC00FFFFF
               	orq	$0x3ff00000, %rcx       # imm = 0x3FF00000
               	movl	%ecx, -0x8(%rbp)
               	movq	%rax, %rcx
               	movl	(%rcx), %eax
               	leave
               	retq

<mk_U5>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movl	$0x0, (%rax)
               	movb	$0x0, 0x4(%rax)
               	movq	%rdi, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x8(%rbp)
               	movb	$0x2, -0x7(%rbp)
               	movb	$0x3, -0x6(%rbp)
               	movb	$0x4, -0x5(%rbp)
               	movb	$0x5, -0x4(%rbp)
               	movq	%rax, %rcx
               	movl	(%rcx), %eax
               	movzbq	0x4(%rcx), %r10
               	shlq	$0x20, %r10
               	orq	%r10, %rax
               	leave
               	retq

<mk_U6>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movl	$0x0, (%rax)
               	movw	$0x0, 0x4(%rax)
               	movq	%rdi, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, -0x8(%rbp)
               	movw	$0x2, -0x6(%rbp)
               	movw	$0x3, -0x4(%rbp)
               	movq	%rax, %rcx
               	movl	(%rcx), %eax
               	movzwq	0x4(%rcx), %r10
               	shlq	$0x20, %r10
               	orq	%r10, %rax
               	leave
               	retq

<mk_U7>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movl	$0x0, (%rax)
               	movw	$0x0, 0x4(%rax)
               	movb	$0x0, 0x6(%rax)
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x8(%rbp)
               	movb	$0x2, -0x7(%rbp)
               	movb	$0x3, -0x6(%rbp)
               	movb	$0x4, -0x5(%rbp)
               	movb	$0x5, -0x4(%rbp)
               	movb	$0x6, -0x3(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movb	$0x7, -0x2(%rbp)
               	movq	%rax, %rcx
               	movl	(%rcx), %eax
               	movzwq	0x4(%rcx), %r10
               	shlq	$0x20, %r10
               	orq	%r10, %rax
               	movzbq	0x6(%rcx), %r10
               	shlq	$0x30, %r10
               	orq	%r10, %rax
               	leave
               	retq

<mk_U12>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	movq	$0x0, (%rax)
               	movl	$0x0, 0x8(%rax)
               	movl	%edi, -0x10(%rbp)
               	movl	$0x2, -0xc(%rbp)
               	movl	$0x3, -0x8(%rbp)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movl	0x8(%rcx), %edx
               	leave
               	retq

<mk_F3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	leaq	-0x10(%rbp), %rax
               	movq	$0x0, (%rax)
               	movl	$0x0, 0x8(%rax)
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rdi, %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movl	$0x40000000, -0xc(%rbp) # imm = 0x40000000
               	movl	$0x40400000, -0x8(%rbp) # imm = 0x40400000
               	movq	%rax, %rcx
               	movsd	(%rcx), %xmm0
               	movss	0x8(%rcx), %xmm1
               	leave
               	retq

<mk_FI>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	leaq	-0x10(%rbp), %rax
               	movq	$0x0, (%rax)
               	movl	$0x0, 0x8(%rax)
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rdi, %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movl	$0x2, -0xc(%rbp)
               	movb	$0x3, -0x8(%rbp)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movl	0x8(%rcx), %edx
               	leave
               	retq

<local_U1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movb	$0x55, -0x7(%rbp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movb	%al, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movzbq	0x1(%rax), %rax
               	movq	%rax, %rcx
               	xorq	$0x55, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	-0x8(%rbp), %rax
               	cmpl	%ebx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq

<param_U1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rdi, -0x60(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x30(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x28(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	movq	%rsi, %rdi
               	callq	<addr>
               	movb	%al, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	movzbq	(%rax), %r10
               	movb	%r10b, (%rcx)
               	movq	-0x60(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	leave
               	retq

<check_param_U1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	-0x60(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movups	%xmm14, 0x20(%r9)
               	movb	$0x55, -0x5f(%rbp)
               	leaq	-0x30(%rbp), %rdi
               	subq	$0x30, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x20(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x28(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	%rbx, %rsi
               	callq	<addr>
               	addq	$0x30, %rsp
               	movzbq	-0x30(%rbp), %rcx
               	movzbq	-0x2f(%rbp), %rax
               	movq	%rax, %rdx
               	xorq	$0x55, %rdx
               	xorl	%eax, %eax
               	testl	%edx, %edx
               	jne	<addr>
               	cmpl	%ebx, %ecx
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq

<local_U2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movb	$0x55, -0x6(%rbp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movw	%ax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movzbq	0x2(%rax), %rax
               	movq	%rax, %rcx
               	xorq	$0x55, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzwq	-0x8(%rbp), %rax
               	cmpl	%ebx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq

<param_U2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rdi, -0x60(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x30(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x28(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	movq	%rsi, %rdi
               	callq	<addr>
               	movw	%ax, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	movzwq	(%rax), %r10
               	movw	%r10w, (%rcx)
               	movq	-0x60(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	leave
               	retq

<check_param_U2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	-0x60(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movups	%xmm14, 0x20(%r9)
               	movb	$0x55, -0x5e(%rbp)
               	leaq	-0x30(%rbp), %rdi
               	subq	$0x30, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x20(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x28(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	%rbx, %rsi
               	callq	<addr>
               	addq	$0x30, %rsp
               	movzwq	-0x30(%rbp), %rcx
               	movzbq	-0x2e(%rbp), %rax
               	movq	%rax, %rdx
               	xorq	$0x55, %rdx
               	xorl	%eax, %eax
               	testl	%edx, %edx
               	jne	<addr>
               	cmpl	%ebx, %ecx
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq

<local_U3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movb	$0x55, -0x5(%rbp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movw	%ax, -0x8(%rbp)
               	shrq	$0x10, %rax
               	movb	%al, -0x6(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movzbq	0x3(%rax), %rax
               	movq	%rax, %rcx
               	xorq	$0x55, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	-0x8(%rbp), %rax
               	cmpl	%ebx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq

<param_U3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rdi, -0x60(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x30(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x28(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	movq	%rsi, %rdi
               	callq	<addr>
               	movw	%ax, -0x38(%rbp)
               	shrq	$0x10, %rax
               	movb	%al, -0x36(%rbp)
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	movzwq	(%rax), %r10
               	movw	%r10w, (%rcx)
               	movzbq	0x2(%rax), %r10
               	movb	%r10b, 0x2(%rcx)
               	movq	-0x60(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	leave
               	retq

<check_param_U3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	-0x60(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movups	%xmm14, 0x20(%r9)
               	movb	$0x55, -0x5d(%rbp)
               	leaq	-0x30(%rbp), %rdi
               	subq	$0x30, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x20(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x28(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	%rbx, %rsi
               	callq	<addr>
               	addq	$0x30, %rsp
               	movzbq	-0x30(%rbp), %rcx
               	movzbq	-0x2d(%rbp), %rax
               	movq	%rax, %rdx
               	xorq	$0x55, %rdx
               	xorl	%eax, %eax
               	testl	%edx, %edx
               	jne	<addr>
               	cmpl	%ebx, %ecx
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq

<local_B4>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movb	$0x55, -0x4(%rbp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movzbq	0x4(%rax), %rax
               	movq	%rax, %rcx
               	xorq	$0x55, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	andq	$0xfffff, %rax          # imm = 0xFFFFF
               	cmpl	%ebx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq

<param_B4>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rdi, -0x60(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x30(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x28(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	movq	%rsi, %rdi
               	callq	<addr>
               	movl	%eax, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	movl	(%rax), %r10d
               	movl	%r10d, (%rcx)
               	movq	-0x60(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	leave
               	retq

<check_param_B4>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	-0x60(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movups	%xmm14, 0x20(%r9)
               	movb	$0x55, -0x5c(%rbp)
               	leaq	-0x30(%rbp), %rdi
               	subq	$0x30, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x20(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x28(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	%rbx, %rsi
               	callq	<addr>
               	addq	$0x30, %rsp
               	movl	-0x30(%rbp), %ecx
               	movzbq	-0x2c(%rbp), %rax
               	movq	%rax, %rdx
               	xorq	$0x55, %rdx
               	xorl	%eax, %eax
               	testl	%edx, %edx
               	jne	<addr>
               	movq	%rcx, %rax
               	andq	$0xfffff, %rax          # imm = 0xFFFFF
               	cmpl	%ebx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq

<local_U5>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movb	$0x55, -0x3(%rbp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	%eax, -0x8(%rbp)
               	shrq	$0x20, %rax
               	movb	%al, -0x4(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movzbq	0x5(%rax), %rax
               	movq	%rax, %rcx
               	xorq	$0x55, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	-0x8(%rbp), %rax
               	cmpl	%ebx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq

<param_U5>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rdi, -0x60(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x30(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x28(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	movq	%rsi, %rdi
               	callq	<addr>
               	movl	%eax, -0x38(%rbp)
               	shrq	$0x20, %rax
               	movb	%al, -0x34(%rbp)
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	movl	(%rax), %r10d
               	movl	%r10d, (%rcx)
               	movzbq	0x4(%rax), %r10
               	movb	%r10b, 0x4(%rcx)
               	movq	-0x60(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	leave
               	retq

<check_param_U5>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	-0x60(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movups	%xmm14, 0x20(%r9)
               	movb	$0x55, -0x5b(%rbp)
               	leaq	-0x30(%rbp), %rdi
               	subq	$0x30, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x20(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x28(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	%rbx, %rsi
               	callq	<addr>
               	addq	$0x30, %rsp
               	movzbq	-0x30(%rbp), %rcx
               	movzbq	-0x2b(%rbp), %rax
               	movq	%rax, %rdx
               	xorq	$0x55, %rdx
               	xorl	%eax, %eax
               	testl	%edx, %edx
               	jne	<addr>
               	cmpl	%ebx, %ecx
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq

<local_U6>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movb	$0x55, -0x2(%rbp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	%eax, -0x8(%rbp)
               	shrq	$0x20, %rax
               	movw	%ax, -0x4(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movzbq	0x6(%rax), %rax
               	movq	%rax, %rcx
               	xorq	$0x55, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzwq	-0x8(%rbp), %rax
               	cmpl	%ebx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq

<param_U6>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rdi, -0x60(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x30(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x28(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	movq	%rsi, %rdi
               	callq	<addr>
               	movl	%eax, -0x38(%rbp)
               	shrq	$0x20, %rax
               	movw	%ax, -0x34(%rbp)
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	movl	(%rax), %r10d
               	movl	%r10d, (%rcx)
               	movzwq	0x4(%rax), %r10
               	movw	%r10w, 0x4(%rcx)
               	movq	-0x60(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	leave
               	retq

<check_param_U6>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	-0x60(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movups	%xmm14, 0x20(%r9)
               	movb	$0x55, -0x5a(%rbp)
               	leaq	-0x30(%rbp), %rdi
               	subq	$0x30, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x20(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x28(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	%rbx, %rsi
               	callq	<addr>
               	addq	$0x30, %rsp
               	movzwq	-0x30(%rbp), %rcx
               	movzbq	-0x2a(%rbp), %rax
               	movq	%rax, %rdx
               	xorq	$0x55, %rdx
               	xorl	%eax, %eax
               	testl	%edx, %edx
               	jne	<addr>
               	cmpl	%ebx, %ecx
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq

<local_U7>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movb	$0x55, -0x1(%rbp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	%eax, -0x8(%rbp)
               	shrq	$0x20, %rax
               	movw	%ax, -0x4(%rbp)
               	shrq	$0x10, %rax
               	movb	%al, -0x2(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movzbq	0x7(%rax), %rax
               	movq	%rax, %rcx
               	xorq	$0x55, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	-0x8(%rbp), %rax
               	cmpl	%ebx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq

<param_U7>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rdi, -0x60(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x30(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x28(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	movq	%rsi, %rdi
               	callq	<addr>
               	movl	%eax, -0x38(%rbp)
               	shrq	$0x20, %rax
               	movw	%ax, -0x34(%rbp)
               	shrq	$0x10, %rax
               	movb	%al, -0x32(%rbp)
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	movl	(%rax), %r10d
               	movl	%r10d, (%rcx)
               	movzwq	0x4(%rax), %r10
               	movw	%r10w, 0x4(%rcx)
               	movzbq	0x6(%rax), %r10
               	movb	%r10b, 0x6(%rcx)
               	movq	-0x60(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	leave
               	retq

<check_param_U7>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	-0x60(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movups	%xmm14, 0x20(%r9)
               	movb	$0x55, -0x59(%rbp)
               	leaq	-0x30(%rbp), %rdi
               	subq	$0x30, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x20(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x28(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	%rbx, %rsi
               	callq	<addr>
               	addq	$0x30, %rsp
               	movzbq	-0x30(%rbp), %rcx
               	movzbq	-0x29(%rbp), %rax
               	movq	%rax, %rdx
               	xorq	$0x55, %rdx
               	xorl	%eax, %eax
               	testl	%edx, %edx
               	jne	<addr>
               	cmpl	%ebx, %ecx
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq

<local_U12>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movb	$0x55, -0x4(%rbp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movl	%edx, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movzbq	0xc(%rax), %rax
               	movq	%rax, %rcx
               	xorq	$0x55, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	-0x10(%rbp), %eax
               	cmpl	%ebx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq

<param_U12>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rdi, -0x70(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x38(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x30(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x28(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	movq	%rsi, %rdi
               	callq	<addr>
               	movq	%rax, -0x48(%rbp)
               	movl	%edx, -0x40(%rbp)
               	leaq	-0x48(%rbp), %rax
               	leaq	-0x38(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rcx)
               	movq	-0x70(%rbp), %rax
               	leaq	-0x38(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	movq	0x30(%rcx), %r10
               	movq	%r10, 0x30(%rax)
               	leave
               	retq

<check_param_U12>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x78, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	-0x70(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movups	%xmm14, 0x20(%r9)
               	movq	$0x0, 0x30(%r9)
               	movb	$0x55, -0x64(%rbp)
               	leaq	-0x38(%rbp), %rdi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x20(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x28(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x30(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	%rbx, %rsi
               	callq	<addr>
               	addq	$0x40, %rsp
               	movl	-0x38(%rbp), %ecx
               	movzbq	-0x2c(%rbp), %rax
               	movq	%rax, %rdx
               	xorq	$0x55, %rdx
               	xorl	%eax, %eax
               	testl	%edx, %edx
               	jne	<addr>
               	cmpl	%ebx, %ecx
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq

<local_F3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movslq	%edi, %rbx
               	movb	$0x55, -0x4(%rbp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	%xmm0, -0x10(%rbp)
               	movss	%xmm1, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movzbq	0xc(%rax), %rax
               	movq	%rax, %rcx
               	xorq	$0x55, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movss	-0x10(%rbp), %xmm0
               	cvttss2si	%xmm0, %rax
               	cmpq	%rbx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq

<param_F3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rdi, -0x70(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x38(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x30(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x28(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	movq	%rsi, %rdi
               	callq	<addr>
               	movsd	%xmm0, -0x48(%rbp)
               	movss	%xmm1, -0x40(%rbp)
               	leaq	-0x48(%rbp), %rax
               	leaq	-0x38(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rcx)
               	movq	-0x70(%rbp), %rax
               	leaq	-0x38(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	movq	0x30(%rcx), %r10
               	movq	%r10, 0x30(%rax)
               	leave
               	retq

<check_param_F3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x78, %rsp
               	pushq	%rbx
               	movslq	%edi, %rbx
               	leaq	-0x70(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movups	%xmm14, 0x20(%r9)
               	movq	$0x0, 0x30(%r9)
               	movb	$0x55, -0x64(%rbp)
               	leaq	-0x38(%rbp), %rdi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x20(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x28(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x30(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	%rbx, %rsi
               	callq	<addr>
               	addq	$0x40, %rsp
               	movzbq	-0x2c(%rbp), %rax
               	movq	%rax, %rcx
               	xorq	$0x55, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movss	-0x38(%rbp), %xmm0
               	cvttss2si	%xmm0, %rax
               	cmpq	%rbx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq

<local_FI>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movslq	%edi, %rbx
               	movb	$0x55, -0x4(%rbp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movl	%edx, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movzbq	0xc(%rax), %rax
               	movq	%rax, %rcx
               	xorq	$0x55, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movss	-0x10(%rbp), %xmm0
               	cvttss2si	%xmm0, %rax
               	cmpq	%rbx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq

<param_FI>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rdi, -0x70(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x38(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x30(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x28(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	movq	%rsi, %rdi
               	callq	<addr>
               	movq	%rax, -0x48(%rbp)
               	movl	%edx, -0x40(%rbp)
               	leaq	-0x48(%rbp), %rax
               	leaq	-0x38(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rcx)
               	movq	-0x70(%rbp), %rax
               	leaq	-0x38(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	movq	0x30(%rcx), %r10
               	movq	%r10, 0x30(%rax)
               	leave
               	retq

<check_param_FI>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x78, %rsp
               	pushq	%rbx
               	movslq	%edi, %rbx
               	leaq	-0x70(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movups	%xmm14, 0x20(%r9)
               	movq	$0x0, 0x30(%r9)
               	movb	$0x55, -0x64(%rbp)
               	leaq	-0x38(%rbp), %rdi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x20(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x28(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x30(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	%rbx, %rsi
               	callq	<addr>
               	addq	$0x40, %rsp
               	movzbq	-0x2c(%rbp), %rax
               	movq	%rax, %rcx
               	xorq	$0x55, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movss	-0x38(%rbp), %xmm0
               	cvttss2si	%xmm0, %rax
               	cmpq	%rbx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa8, %rsp
               	pushq	%rbx
               	leaq	-0xa0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	movups	%xmm14, 0x60(%rax)
               	movups	%xmm14, 0x70(%rax)
               	movups	%xmm14, 0x80(%rax)
               	movups	%xmm14, 0x90(%rax)
               	leaq	-<rip>, %rax      # <addr>
               	movq	%rax, -0xa0(%rbp)
               	leaq	-<rip>, %rax      # <addr>
               	movq	%rax, -0x98(%rbp)
               	leaq	-<rip>, %rax      # <addr>
               	movq	%rax, -0x90(%rbp)
               	leaq	-<rip>, %rax      # <addr>
               	movq	%rax, -0x88(%rbp)
               	leaq	-<rip>, %rax      # <addr>
               	movq	%rax, -0x80(%rbp)
               	leaq	-<rip>, %rax      # <addr>
               	movq	%rax, -0x78(%rbp)
               	leaq	-<rip>, %rax      # <addr>
               	movq	%rax, -0x70(%rbp)
               	leaq	-<rip>, %rax      # <addr>
               	movq	%rax, -0x68(%rbp)
               	leaq	-<rip>, %rax      # <addr>
               	movq	%rax, -0x60(%rbp)
               	leaq	-<rip>, %rax      # <addr>
               	movq	%rax, -0x58(%rbp)
               	leaq	-<rip>, %rax      # <addr>
               	movq	%rax, -0x50(%rbp)
               	leaq	-<rip>, %rax      # <addr>
               	movq	%rax, -0x48(%rbp)
               	leaq	-<rip>, %rax      # <addr>
               	movq	%rax, -0x40(%rbp)
               	leaq	-<rip>, %rax      # <addr>
               	movq	%rax, -0x38(%rbp)
               	leaq	-<rip>, %rax      # <addr>
               	movq	%rax, -0x30(%rbp)
               	leaq	-<rip>, %rax      # <addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-<rip>, %rax      # <addr>
               	movq	%rax, -0x20(%rbp)
               	leaq	-<rip>, %rax      # <addr>
               	movq	%rax, -0x18(%rbp)
               	leaq	-<rip>, %rax      # <addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-<rip>, %rax      # <addr>
               	movq	%rax, -0x8(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0xa0(%rbp), %rax
               	movq	(%rax,%rbx,8), %rax
               	movl	$0x27, %edi
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	incq	%rbx
               	cmpl	$0x14, %ebx
               	jb	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	0x1(%rbx), %rax
               	popq	%rbx
               	leave
               	retq
