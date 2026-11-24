
call_result_into_member.x64:	file format elf64-x86-64

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

<keep>:
               	movq	%rdi, <rip> # <addr>
               	retq

<mk_U1>:
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	retq

<mk_U2>:
               	movq	%rdi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	retq

<mk_U3>:
               	andq	$0xff, %rdi
               	movq	%rdi, %rax
               	orq	$0x200, %rax            # imm = 0x200
               	orq	$0x30000, %rax          # imm = 0x30000
               	retq

<mk_B4>:
               	movq	%rdi, %rax
               	andq	$0xfffff, %rax          # imm = 0xFFFFF
               	orq	$0x3ff00000, %rax       # imm = 0x3FF00000
               	retq

<mk_U5>:
               	andq	$0xff, %rdi
               	orq	$0x200, %rdi            # imm = 0x200
               	orq	$0x30000, %rdi          # imm = 0x30000
               	orq	$0x4000000, %rdi        # imm = 0x4000000
               	movabsq	$0x500000000, %rax      # imm = 0x500000000
               	orq	%rdi, %rax
               	retq

<mk_U6>:
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	orq	$0x20000, %rdi          # imm = 0x20000
               	movabsq	$0x300000000, %rax      # imm = 0x300000000
               	orq	%rdi, %rax
               	retq

<mk_U7>:
               	andq	$0xff, %rdi
               	orq	$0x200, %rdi            # imm = 0x200
               	orq	$0x30000, %rdi          # imm = 0x30000
               	orq	$0x4000000, %rdi        # imm = 0x4000000
               	movabsq	$0x60500000000, %rax    # imm = 0x60500000000
               	orq	%rdi, %rax
               	movabsq	$0x7000000000000, %r11  # imm = 0x7000000000000
               	orq	%r11, %rax
               	retq

<mk_U12>:
               	movl	%edi, %eax
               	movabsq	$0x200000000, %r11      # imm = 0x200000000
               	orq	%r11, %rax
               	movl	$0x3, %edx
               	retq

<mk_F3>:
               	subq	$0x18, %rsp
               	movslq	%edi, %rdi
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rdi, %xmm0
               	leaq	(%rsp), %rax
               	movss	%xmm0, (%rsp)
               	movl	$0x40000000, 0x4(%rsp)  # imm = 0x40000000
               	movl	$0x40400000, 0x8(%rsp)  # imm = 0x40400000
               	movq	%rax, %rcx
               	movsd	(%rcx), %xmm0
               	movss	0x8(%rcx), %xmm1
               	addq	$0x18, %rsp
               	retq

<mk_FI>:
               	subq	$0x18, %rsp
               	movslq	%edi, %rdi
               	leaq	(%rsp), %rax
               	movq	$0x0, (%rax)
               	movl	$0x0, 0x8(%rax)
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rdi, %xmm0
               	movss	%xmm0, (%rsp)
               	movl	$0x2, 0x4(%rsp)
               	movl	$0x3, %edx
               	movb	%dl, 0x8(%rsp)
               	movq	(%rsp), %rax
               	addq	$0x18, %rsp
               	retq

<local_U1>:
               	subq	$0x20, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movb	$0x55, 0x19(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	andq	$0xff, %rax
               	movb	%al, 0x18(%rsp)
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movzbq	0x1(%rax), %rax
               	movq	%rax, %rcx
               	xorq	$0x55, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x18(%rsp), %rax
               	cmpl	%ebx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq

<param_U1>:
               	subq	$0x68, %rsp
               	movq	%rdi, (%rsp)
               	movq	0x70(%rsp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x78(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x80(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x88(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x90(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x98(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rsi, %rdi
               	callq	<addr>
               	movb	%al, 0x28(%rsp)
               	leaq	0x30(%rsp), %rcx
               	movb	%al, (%rcx)
               	movq	(%rsp), %rax
               	leaq	0x30(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	addq	$0x68, %rsp
               	retq

<check_param_U1>:
               	subq	$0x70, %rsp
               	pushq	%rbx
               	subq	$0x30, %rsp
               	movq	%rdi, %rbx
               	leaq	0x40(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movups	%xmm14, 0x20(%r9)
               	movb	$0x55, 0x41(%rsp)
               	leaq	0x70(%rsp), %rdi
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
               	movzbq	0x70(%rsp), %rax
               	movzbq	0x71(%rsp), %rcx
               	xorl	%edx, %edx
               	cmpl	%ebx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x55, %ecx
               	cmovneq	%rdx, %rax
               	addq	$0x30, %rsp
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq

<local_U2>:
               	subq	$0x20, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movb	$0x55, 0x1a(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x18(%rsp)
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movzbq	0x2(%rax), %rax
               	movq	%rax, %rcx
               	xorq	$0x55, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzwq	0x18(%rsp), %rax
               	cmpl	%ebx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq

<param_U2>:
               	subq	$0x68, %rsp
               	movq	%rdi, (%rsp)
               	movq	0x70(%rsp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x78(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x80(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x88(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x90(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x98(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rsi, %rdi
               	callq	<addr>
               	movw	%ax, 0x28(%rsp)
               	leaq	0x30(%rsp), %rcx
               	movw	%ax, (%rcx)
               	movq	(%rsp), %rax
               	leaq	0x30(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	addq	$0x68, %rsp
               	retq

<check_param_U2>:
               	subq	$0x70, %rsp
               	pushq	%rbx
               	subq	$0x30, %rsp
               	movq	%rdi, %rbx
               	leaq	0x40(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movups	%xmm14, 0x20(%r9)
               	movb	$0x55, 0x42(%rsp)
               	leaq	0x70(%rsp), %rdi
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
               	movzwq	0x70(%rsp), %rax
               	movzbq	0x72(%rsp), %rcx
               	xorl	%edx, %edx
               	cmpl	%ebx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x55, %ecx
               	cmovneq	%rdx, %rax
               	addq	$0x30, %rsp
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq

<local_U3>:
               	subq	$0x20, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movb	$0x55, 0x1b(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movw	%ax, 0x18(%rsp)
               	shrq	$0x10, %rax
               	movb	%al, 0x1a(%rsp)
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movzbq	0x3(%rax), %rax
               	movq	%rax, %rcx
               	xorq	$0x55, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x18(%rsp), %rax
               	cmpl	%ebx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq

<param_U3>:
               	subq	$0x68, %rsp
               	movq	%rdi, (%rsp)
               	movq	0x70(%rsp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x78(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x80(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x88(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x90(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x98(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rsi, %rdi
               	callq	<addr>
               	movw	%ax, 0x28(%rsp)
               	shrq	$0x10, %rax
               	leaq	0x28(%rsp), %rcx
               	movb	%al, 0x2a(%rsp)
               	leaq	0x30(%rsp), %rax
               	movzwq	(%rcx), %r10
               	movw	%r10w, (%rax)
               	movzbq	0x2(%rcx), %r10
               	movb	%r10b, 0x2(%rax)
               	movq	(%rsp), %rax
               	leaq	0x30(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	addq	$0x68, %rsp
               	retq

<check_param_U3>:
               	subq	$0x70, %rsp
               	pushq	%rbx
               	subq	$0x30, %rsp
               	movq	%rdi, %rbx
               	leaq	0x40(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movups	%xmm14, 0x20(%r9)
               	movb	$0x55, 0x43(%rsp)
               	leaq	0x70(%rsp), %rdi
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
               	movzbq	0x70(%rsp), %rax
               	movzbq	0x73(%rsp), %rcx
               	xorl	%edx, %edx
               	cmpl	%ebx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x55, %ecx
               	cmovneq	%rdx, %rax
               	addq	$0x30, %rsp
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq

<local_B4>:
               	subq	$0x20, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movb	$0x55, 0x1c(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	%eax, 0x18(%rsp)
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movzbq	0x4(%rax), %rax
               	movq	%rax, %rcx
               	xorq	$0x55, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	0x18(%rsp), %eax
               	andq	$0xfffff, %rax          # imm = 0xFFFFF
               	cmpl	%ebx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq

<param_B4>:
               	subq	$0x68, %rsp
               	movq	%rdi, (%rsp)
               	movq	0x70(%rsp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x78(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x80(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x88(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x90(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x98(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rsi, %rdi
               	callq	<addr>
               	movl	%eax, 0x28(%rsp)
               	leaq	0x30(%rsp), %rcx
               	movl	%eax, (%rcx)
               	movq	(%rsp), %rax
               	leaq	0x30(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	addq	$0x68, %rsp
               	retq

<check_param_B4>:
               	subq	$0x70, %rsp
               	pushq	%rbx
               	subq	$0x30, %rsp
               	movq	%rdi, %rbx
               	leaq	0x40(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movups	%xmm14, 0x20(%r9)
               	movb	$0x55, 0x44(%rsp)
               	leaq	0x70(%rsp), %rdi
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
               	movl	0x70(%rsp), %eax
               	movzbq	0x74(%rsp), %rcx
               	xorl	%edx, %edx
               	andq	$0xfffff, %rax          # imm = 0xFFFFF
               	cmpl	%ebx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x55, %ecx
               	cmovneq	%rdx, %rax
               	addq	$0x30, %rsp
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq

<local_U5>:
               	subq	$0x20, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movb	$0x55, 0x1d(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	%eax, 0x18(%rsp)
               	shrq	$0x20, %rax
               	movb	%al, 0x1c(%rsp)
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movzbq	0x5(%rax), %rax
               	movq	%rax, %rcx
               	xorq	$0x55, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x18(%rsp), %rax
               	cmpl	%ebx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq

<param_U5>:
               	subq	$0x68, %rsp
               	movq	%rdi, (%rsp)
               	movq	0x70(%rsp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x78(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x80(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x88(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x90(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x98(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rsi, %rdi
               	callq	<addr>
               	movl	%eax, 0x28(%rsp)
               	shrq	$0x20, %rax
               	leaq	0x28(%rsp), %rcx
               	movb	%al, 0x2c(%rsp)
               	leaq	0x30(%rsp), %rax
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movzbq	0x4(%rcx), %r10
               	movb	%r10b, 0x4(%rax)
               	movq	(%rsp), %rax
               	leaq	0x30(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	addq	$0x68, %rsp
               	retq

<check_param_U5>:
               	subq	$0x70, %rsp
               	pushq	%rbx
               	subq	$0x30, %rsp
               	movq	%rdi, %rbx
               	leaq	0x40(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movups	%xmm14, 0x20(%r9)
               	movb	$0x55, 0x45(%rsp)
               	leaq	0x70(%rsp), %rdi
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
               	movzbq	0x70(%rsp), %rax
               	movzbq	0x75(%rsp), %rcx
               	xorl	%edx, %edx
               	cmpl	%ebx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x55, %ecx
               	cmovneq	%rdx, %rax
               	addq	$0x30, %rsp
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq

<local_U6>:
               	subq	$0x20, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movb	$0x55, 0x1e(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	%eax, 0x18(%rsp)
               	shrq	$0x20, %rax
               	movw	%ax, 0x1c(%rsp)
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movzbq	0x6(%rax), %rax
               	movq	%rax, %rcx
               	xorq	$0x55, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzwq	0x18(%rsp), %rax
               	cmpl	%ebx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq

<param_U6>:
               	subq	$0x68, %rsp
               	movq	%rdi, (%rsp)
               	movq	0x70(%rsp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x78(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x80(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x88(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x90(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x98(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rsi, %rdi
               	callq	<addr>
               	movl	%eax, 0x28(%rsp)
               	shrq	$0x20, %rax
               	leaq	0x28(%rsp), %rcx
               	movw	%ax, 0x2c(%rsp)
               	leaq	0x30(%rsp), %rax
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movzwq	0x4(%rcx), %r10
               	movw	%r10w, 0x4(%rax)
               	movq	(%rsp), %rax
               	leaq	0x30(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	addq	$0x68, %rsp
               	retq

<check_param_U6>:
               	subq	$0x70, %rsp
               	pushq	%rbx
               	subq	$0x30, %rsp
               	movq	%rdi, %rbx
               	leaq	0x40(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movups	%xmm14, 0x20(%r9)
               	movb	$0x55, 0x46(%rsp)
               	leaq	0x70(%rsp), %rdi
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
               	movzwq	0x70(%rsp), %rax
               	movzbq	0x76(%rsp), %rcx
               	xorl	%edx, %edx
               	cmpl	%ebx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x55, %ecx
               	cmovneq	%rdx, %rax
               	addq	$0x30, %rsp
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq

<local_U7>:
               	subq	$0x20, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movb	$0x55, 0x1f(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	%eax, 0x18(%rsp)
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	movw	%cx, 0x1c(%rsp)
               	shrq	$0x30, %rax
               	movb	%al, 0x1e(%rsp)
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movzbq	0x7(%rax), %rax
               	movq	%rax, %rcx
               	xorq	$0x55, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x18(%rsp), %rax
               	cmpl	%ebx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq

<param_U7>:
               	subq	$0x68, %rsp
               	movq	%rdi, (%rsp)
               	movq	0x70(%rsp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x78(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x80(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x88(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x90(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x98(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rsi, %rdi
               	callq	<addr>
               	movl	%eax, 0x28(%rsp)
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	leaq	0x28(%rsp), %rdx
               	movw	%cx, 0x2c(%rsp)
               	shrq	$0x30, %rax
               	movb	%al, 0x2e(%rsp)
               	leaq	0x30(%rsp), %rax
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rax)
               	movzwq	0x4(%rdx), %r10
               	movw	%r10w, 0x4(%rax)
               	movzbq	0x6(%rdx), %r10
               	movb	%r10b, 0x6(%rax)
               	movq	(%rsp), %rax
               	leaq	0x30(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	addq	$0x68, %rsp
               	retq

<check_param_U7>:
               	subq	$0x70, %rsp
               	pushq	%rbx
               	subq	$0x30, %rsp
               	movq	%rdi, %rbx
               	leaq	0x40(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movups	%xmm14, 0x20(%r9)
               	movb	$0x55, 0x47(%rsp)
               	leaq	0x70(%rsp), %rdi
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
               	movzbq	0x70(%rsp), %rax
               	movzbq	0x77(%rsp), %rcx
               	xorl	%edx, %edx
               	cmpl	%ebx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x55, %ecx
               	cmovneq	%rdx, %rax
               	addq	$0x30, %rsp
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq

<local_U12>:
               	subq	$0x20, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movb	$0x55, 0x1c(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, 0x10(%rsp)
               	movl	%edx, 0x18(%rsp)
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movzbq	0xc(%rax), %rax
               	movq	%rax, %rcx
               	xorq	$0x55, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	0x10(%rsp), %eax
               	cmpl	%ebx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq

<param_U12>:
               	subq	$0x78, %rsp
               	movq	%rdi, (%rsp)
               	movq	0x80(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x88(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x90(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x98(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0xa0(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0xa8(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0xb0(%rsp), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	%rsi, %rdi
               	callq	<addr>
               	movq	%rax, 0x28(%rsp)
               	leaq	0x28(%rsp), %rax
               	movl	%edx, 0x30(%rsp)
               	leaq	0x38(%rsp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rcx)
               	movq	(%rsp), %rax
               	leaq	0x38(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	movq	0x30(%rcx), %r10
               	movq	%r10, 0x30(%rax)
               	addq	$0x78, %rsp
               	retq

<check_param_U12>:
               	subq	$0x80, %rsp
               	pushq	%rbx
               	subq	$0x40, %rsp
               	movq	%rdi, %rbx
               	leaq	0x50(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movups	%xmm14, 0x20(%r9)
               	movq	$0x0, 0x30(%r9)
               	movb	$0x55, 0x5c(%rsp)
               	leaq	0x88(%rsp), %rdi
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
               	movl	0x88(%rsp), %eax
               	movzbq	0x94(%rsp), %rcx
               	xorl	%edx, %edx
               	cmpl	%ebx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x55, %ecx
               	cmovneq	%rdx, %rax
               	addq	$0x40, %rsp
               	popq	%rbx
               	addq	$0x80, %rsp
               	retq

<local_F3>:
               	subq	$0x20, %rsp
               	pushq	%rbx
               	movslq	%edi, %rbx
               	movb	$0x55, 0x1c(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	%xmm0, 0x10(%rsp)
               	movss	%xmm1, 0x18(%rsp)
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movzbq	0xc(%rax), %rax
               	movq	%rax, %rcx
               	xorq	$0x55, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movss	0x10(%rsp), %xmm0
               	cvttss2si	%xmm0, %rax
               	cmpq	%rbx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq

<param_F3>:
               	subq	$0x78, %rsp
               	movq	%rdi, (%rsp)
               	movq	0x80(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x88(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x90(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x98(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0xa0(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0xa8(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0xb0(%rsp), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	%rsi, %rdi
               	callq	<addr>
               	movsd	%xmm0, 0x28(%rsp)
               	movss	%xmm1, 0x30(%rsp)
               	leaq	0x28(%rsp), %rax
               	leaq	0x38(%rsp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rcx)
               	movq	(%rsp), %rax
               	leaq	0x38(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	movq	0x30(%rcx), %r10
               	movq	%r10, 0x30(%rax)
               	addq	$0x78, %rsp
               	retq

<check_param_F3>:
               	subq	$0x80, %rsp
               	pushq	%rbx
               	subq	$0x40, %rsp
               	movslq	%edi, %rbx
               	leaq	0x50(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movups	%xmm14, 0x20(%r9)
               	movq	$0x0, 0x30(%r9)
               	movb	$0x55, 0x5c(%rsp)
               	leaq	0x88(%rsp), %rdi
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
               	movzbq	0x94(%rsp), %rax
               	movq	%rax, %rcx
               	xorq	$0x55, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movss	0x88(%rsp), %xmm0
               	cvttss2si	%xmm0, %rax
               	cmpq	%rbx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	addq	$0x40, %rsp
               	popq	%rbx
               	addq	$0x80, %rsp
               	retq

<local_FI>:
               	subq	$0x20, %rsp
               	pushq	%rbx
               	movslq	%edi, %rbx
               	movb	$0x55, 0x1c(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, 0x10(%rsp)
               	movb	%dl, 0x18(%rsp)
               	movq	%rdx, %rax
               	shrq	$0x8, %rax
               	movb	%al, 0x19(%rsp)
               	shrq	$0x10, %rdx
               	movw	%dx, 0x1a(%rsp)
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movzbq	0xc(%rax), %rax
               	movq	%rax, %rcx
               	xorq	$0x55, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movss	0x10(%rsp), %xmm0
               	cvttss2si	%xmm0, %rax
               	cmpq	%rbx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq

<param_FI>:
               	subq	$0x78, %rsp
               	movq	%rdi, (%rsp)
               	movq	0x80(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x88(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x90(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x98(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0xa0(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0xa8(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0xb0(%rsp), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	%rsi, %rdi
               	callq	<addr>
               	movq	%rax, 0x28(%rsp)
               	leaq	0x28(%rsp), %rax
               	movl	%edx, 0x30(%rsp)
               	leaq	0x38(%rsp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rcx)
               	movq	(%rsp), %rax
               	leaq	0x38(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	movq	0x30(%rcx), %r10
               	movq	%r10, 0x30(%rax)
               	addq	$0x78, %rsp
               	retq

<check_param_FI>:
               	subq	$0x80, %rsp
               	pushq	%rbx
               	subq	$0x40, %rsp
               	movslq	%edi, %rbx
               	leaq	0x50(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movups	%xmm14, 0x20(%r9)
               	movq	$0x0, 0x30(%r9)
               	movb	$0x55, 0x5c(%rsp)
               	leaq	0x88(%rsp), %rdi
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
               	movzbq	0x94(%rsp), %rax
               	movq	%rax, %rcx
               	xorq	$0x55, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movss	0x88(%rsp), %xmm0
               	cvttss2si	%xmm0, %rax
               	cmpq	%rbx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	addq	$0x40, %rsp
               	popq	%rbx
               	addq	$0x80, %rsp
               	retq

<main>:
               	subq	$0xb0, %rsp
               	pushq	%rbx
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x10(%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x18(%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x20(%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x28(%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x30(%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x38(%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x40(%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x48(%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x50(%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x58(%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x60(%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x68(%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x70(%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x78(%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x80(%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x88(%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x90(%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x98(%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0xa0(%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0xa8(%rsp)
               	xorl	%ebx, %ebx
               	movq	0x10(%rsp,%rbx,8), %rax
               	movl	$0x27, %edi
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	incq	%rbx
               	cmpl	$0x14, %ebx
               	jb	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0xb0, %rsp
               	retq
               	leaq	0x1(%rbx), %rax
               	popq	%rbx
               	addq	$0xb0, %rsp
               	retq
