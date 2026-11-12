
vector_abi_variadic.x64:	file format elf64-x86-64

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

<lane_sum>:
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
               	leaq	-0x18(%rbp), %rdx
               	movq	%rdx, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, 0x4(%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	movq	%r10, 0x8(%r11)
               	addq	$0x10, 0x8(%r11)
               	movq	%r10, %rdx
               	movups	(%rdx), %xmm0
               	vpextrb	$0x0, %xmm0, %edx
               	vpextrb	$0xf, %xmm0, %esi
               	addq	%rsi, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	movl	-0xd0(%rbp), %edx
               	cmpl	%edx, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	movq	%rcx, %rax
               	leave
               	retq

<lane_sum8>:
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
               	leaq	-0x18(%rbp), %rdx
               	movq	%rdx, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, 0x4(%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rdx
               	movsd	(%rdx), %xmm0
               	vpextrb	$0x0, %xmm0, %edx
               	vpextrb	$0x7, %xmm0, %esi
               	addq	%rsi, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	movl	-0xd0(%rbp), %edx
               	cmpl	%edx, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	movq	%rcx, %rax
               	leave
               	retq

<interleaved>:
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
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movl	-0xd0(%rbp), %ecx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rcx
               	movslq	(%rcx), %rcx
               	leaq	-0x18(%rbp), %rdx
               	movq	%rdx, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, 0x4(%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rdx
               	movsd	(%rdx), %xmm1
               	leaq	-0x18(%rbp), %rdx
               	movq	%rdx, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, 0x4(%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	movq	%r10, 0x8(%r11)
               	addq	$0x10, 0x8(%r11)
               	movq	%r10, %rdx
               	movups	(%rdx), %xmm2
               	xorps	%xmm3, %xmm3
               	cvtsi2sd	%rcx, %xmm3
               	vaddsd	%xmm1, %xmm3, %xmm1
               	vpextrb	$0x3, %xmm2, %ecx
               	xorps	%xmm2, %xmm2
               	cvtsi2sd	%rcx, %xmm2
               	addsd	%xmm2, %xmm1
               	addsd	%xmm1, %xmm0
               	incq	%rax
               	movl	-0xd0(%rbp), %ecx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	leave
               	retq

<bank_edge>:
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
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movl	-0xd0(%rbp), %ecx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, 0x4(%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rcx
               	movsd	(%rcx), %xmm2
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, 0x4(%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rcx
               	movsd	(%rcx), %xmm1
               	vpextrb	$0x0, %xmm1, %ecx
               	vpextrb	$0x7, %xmm1, %edx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rcx, %xmm1
               	vaddsd	%xmm1, %xmm2, %xmm1
               	addsd	%xmm1, %xmm0
               	incq	%rax
               	movl	-0xd0(%rbp), %ecx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	leave
               	retq

<ramp>:
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm0
               	vpinsrb	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x1(%rax), %rcx
               	andq	$0xff, %rcx
               	vpinsrb	$0x1, %ecx, %xmm0, %xmm0
               	leaq	0x2(%rax), %rcx
               	andq	$0xff, %rcx
               	vpinsrb	$0x2, %ecx, %xmm0, %xmm0
               	leaq	0x3(%rax), %rcx
               	andq	$0xff, %rcx
               	vpinsrb	$0x3, %ecx, %xmm0, %xmm0
               	leaq	0x4(%rax), %rcx
               	andq	$0xff, %rcx
               	vpinsrb	$0x4, %ecx, %xmm0, %xmm0
               	leaq	0x5(%rax), %rcx
               	andq	$0xff, %rcx
               	vpinsrb	$0x5, %ecx, %xmm0, %xmm0
               	leaq	0x6(%rax), %rcx
               	andq	$0xff, %rcx
               	vpinsrb	$0x6, %ecx, %xmm0, %xmm0
               	addq	$0x7, %rax
               	andq	$0xff, %rax
               	vpinsrb	$0x7, %eax, %xmm0, %xmm0
               	andq	$0xff, %rdi
               	leaq	0x8(%rdi), %rax
               	andq	$0xff, %rax
               	vpinsrb	$0x8, %eax, %xmm0, %xmm0
               	leaq	0x9(%rdi), %rax
               	andq	$0xff, %rax
               	vpinsrb	$0x9, %eax, %xmm0, %xmm0
               	leaq	0xa(%rdi), %rax
               	andq	$0xff, %rax
               	vpinsrb	$0xa, %eax, %xmm0, %xmm0
               	leaq	0xb(%rdi), %rax
               	andq	$0xff, %rax
               	vpinsrb	$0xb, %eax, %xmm0, %xmm0
               	leaq	0xc(%rdi), %rax
               	andq	$0xff, %rax
               	vpinsrb	$0xc, %eax, %xmm0, %xmm0
               	leaq	0xd(%rdi), %rax
               	andq	$0xff, %rax
               	vpinsrb	$0xd, %eax, %xmm0, %xmm0
               	leaq	0xe(%rdi), %rax
               	andq	$0xff, %rax
               	vpinsrb	$0xe, %eax, %xmm0, %xmm0
               	leaq	0xf(%rdi), %rax
               	andq	$0xff, %rax
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x110, %rsp            # imm = 0x110
               	movl	$0x1, %edi
               	callq	<addr>
               	movups	%xmm0, -0x110(%rbp)
               	movl	$0x3, %edi
               	callq	<addr>
               	movups	%xmm0, -0x100(%rbp)
               	leaq	-0x100(%rbp), %r9
               	movl	$0x2, %edi
               	leaq	-0x110(%rbp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	movb	$0x2, %al
               	callq	<addr>
               	cmpl	$0x26, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movups	%xmm0, -0xf0(%rbp)
               	movl	$0x2, %edi
               	callq	<addr>
               	movups	%xmm0, -0xe0(%rbp)
               	movl	$0x3, %edi
               	callq	<addr>
               	movups	%xmm0, -0xd0(%rbp)
               	movl	$0x4, %edi
               	callq	<addr>
               	movups	%xmm0, -0xc0(%rbp)
               	movl	$0x5, %edi
               	callq	<addr>
               	movups	%xmm0, -0xb0(%rbp)
               	movl	$0x6, %edi
               	callq	<addr>
               	movups	%xmm0, -0xa0(%rbp)
               	movl	$0x7, %edi
               	callq	<addr>
               	movups	%xmm0, -0x90(%rbp)
               	movl	$0x8, %edi
               	callq	<addr>
               	movups	%xmm0, -0x80(%rbp)
               	movl	$0x9, %edi
               	callq	<addr>
               	movups	%xmm0, -0x110(%rbp)
               	movl	$0xa, %edi
               	callq	<addr>
               	movups	%xmm0, -0x100(%rbp)
               	leaq	-0x100(%rbp), %r9
               	movl	$0xa, %edi
               	leaq	-0xf0(%rbp), %rax
               	leaq	-0xe0(%rbp), %rcx
               	leaq	-0xd0(%rbp), %rdx
               	leaq	-0xc0(%rbp), %rsi
               	leaq	-0xb0(%rbp), %r8
               	leaq	-0xa0(%rbp), %r10
               	movq	%r10, 0xc8(%rsp)
               	leaq	-0x90(%rbp), %r10
               	movq	%r10, 0xc0(%rsp)
               	leaq	-0x80(%rbp), %r10
               	movq	%r10, 0xb8(%rsp)
               	leaq	-0x110(%rbp), %r10
               	movq	%r10, 0xb0(%rsp)
               	subq	$0x20, %rsp
               	movq	0xd0(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%rcx, %r10
               	movups	(%r10), %xmm1
               	movq	%rdx, %r10
               	movups	(%r10), %xmm2
               	movq	%rsi, %r10
               	movups	(%r10), %xmm3
               	movq	%r8, %r10
               	movups	(%r10), %xmm4
               	movq	0xe8(%rsp), %r10
               	movups	(%r10), %xmm5
               	movq	0xe0(%rsp), %r10
               	movups	(%r10), %xmm6
               	movq	0xd8(%rsp), %r10
               	movups	(%r10), %xmm7
               	movb	$0x8, %al
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpl	$0x104, %eax            # imm = 0x104
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movb	$0x5, -0x8(%rbp)
               	movb	$0x6, -0x7(%rbp)
               	movb	$0x7, -0x6(%rbp)
               	movb	$0x8, -0x5(%rbp)
               	movb	$0x9, -0x4(%rbp)
               	movb	$0xa, -0x3(%rbp)
               	movb	$0xb, -0x2(%rbp)
               	leaq	-0x8(%rbp), %r9
               	movb	$0xc, -0x1(%rbp)
               	movl	$0x1, %edi
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	cmpl	$0x11, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0xa, %edi
               	callq	<addr>
               	movups	%xmm0, -0x110(%rbp)
               	movl	$0x14, %edi
               	callq	<addr>
               	movups	%xmm0, -0x100(%rbp)
               	leaq	-0x100(%rbp), %r9
               	movl	$0x2, %edi
               	movl	$0x7, %esi
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	leaq	-0x110(%rbp), %rcx
               	movl	$0x9, %edx
               	movabsq	$0x3fd0000000000000, %r8 # imm = 0x3FD0000000000000
               	movq	%rax, %xmm0
               	movq	%r8, %xmm2
               	movq	%rcx, %r10
               	movups	(%r10), %xmm1
               	movq	%r9, %r10
               	movups	(%r10), %xmm3
               	movb	$0x4, %al
               	callq	<addr>
               	movabsq	$0x404a600000000000, %rax # imm = 0x404A600000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x6, %edi
               	movabsq	$0x3fd0000000000000, %rdx # imm = 0x3FD0000000000000
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm0
               	vpinsrb	$0x0, %eax, %xmm0, %xmm0
               	movl	$0x2, %eax
               	vpinsrb	$0x1, %eax, %xmm0, %xmm0
               	movl	$0x3, %ecx
               	vpinsrb	$0x2, %ecx, %xmm0, %xmm0
               	movl	$0x4, %esi
               	vpinsrb	$0x3, %esi, %xmm0, %xmm0
               	movl	$0x5, %esi
               	vpinsrb	$0x4, %esi, %xmm0, %xmm0
               	vpinsrb	$0x5, %edi, %xmm0, %xmm0
               	movl	$0x7, %esi
               	vpinsrb	$0x6, %esi, %xmm0, %xmm0
               	movl	$0x8, %esi
               	vpinsrb	$0x7, %esi, %xmm0, %xmm0
               	leaq	-0x38(%rbp), %r9
               	vmovq	%xmm0, %rsi
               	movq	%rsi, -0x38(%rbp)
               	movabsq	$0x3fe0000000000000, %rsi # imm = 0x3FE0000000000000
               	vpinsrb	$0x0, %eax, %xmm0, %xmm0
               	vpinsrb	$0x1, %ecx, %xmm0, %xmm0
               	movl	$0x4, %eax
               	vpinsrb	$0x2, %eax, %xmm0, %xmm0
               	movl	$0x5, %eax
               	vpinsrb	$0x3, %eax, %xmm0, %xmm0
               	movl	$0x6, %eax
               	vpinsrb	$0x4, %eax, %xmm0, %xmm0
               	movl	$0x7, %eax
               	vpinsrb	$0x5, %eax, %xmm0, %xmm0
               	movl	$0x8, %eax
               	vpinsrb	$0x6, %eax, %xmm0, %xmm0
               	movl	$0x9, %eax
               	vpinsrb	$0x7, %eax, %xmm0, %xmm0
               	leaq	-0x30(%rbp), %rax
               	vmovq	%xmm0, %rcx
               	movq	%rcx, -0x30(%rbp)
               	movabsq	$0x3fe8000000000000, %rcx # imm = 0x3FE8000000000000
               	movl	$0x3, %r8d
               	vpinsrb	$0x0, %r8d, %xmm0, %xmm0
               	movl	$0x4, %r8d
               	vpinsrb	$0x1, %r8d, %xmm0, %xmm0
               	movl	$0x5, %r8d
               	vpinsrb	$0x2, %r8d, %xmm0, %xmm0
               	movl	$0x6, %r8d
               	vpinsrb	$0x3, %r8d, %xmm0, %xmm0
               	movl	$0x7, %r8d
               	vpinsrb	$0x4, %r8d, %xmm0, %xmm0
               	movl	$0x8, %r8d
               	vpinsrb	$0x5, %r8d, %xmm0, %xmm0
               	movl	$0x9, %r8d
               	vpinsrb	$0x6, %r8d, %xmm0, %xmm0
               	movl	$0xa, %r8d
               	vpinsrb	$0x7, %r8d, %xmm0, %xmm0
               	vmovq	%xmm0, %r8
               	movq	%r8, -0x28(%rbp)
               	leaq	-0x28(%rbp), %r8
               	movabsq	$0x3ff0000000000000, %r10 # imm = 0x3FF0000000000000
               	movq	%r10, 0xc8(%rsp)
               	movl	$0x4, %r10d
               	movq	%r10, 0xc0(%rsp)
               	movq	0xc0(%rsp), %r11
               	vpinsrb	$0x0, %r11d, %xmm0, %xmm0
               	movl	$0x5, %r10d
               	movq	%r10, 0xc0(%rsp)
               	movq	0xc0(%rsp), %r11
               	vpinsrb	$0x1, %r11d, %xmm0, %xmm0
               	movl	$0x6, %r10d
               	movq	%r10, 0xc0(%rsp)
               	movq	0xc0(%rsp), %r11
               	vpinsrb	$0x2, %r11d, %xmm0, %xmm0
               	movl	$0x7, %r10d
               	movq	%r10, 0xc0(%rsp)
               	movq	0xc0(%rsp), %r11
               	vpinsrb	$0x3, %r11d, %xmm0, %xmm0
               	movl	$0x8, %r10d
               	movq	%r10, 0xc0(%rsp)
               	movq	0xc0(%rsp), %r11
               	vpinsrb	$0x4, %r11d, %xmm0, %xmm0
               	movl	$0x9, %r10d
               	movq	%r10, 0xc0(%rsp)
               	movq	0xc0(%rsp), %r11
               	vpinsrb	$0x5, %r11d, %xmm0, %xmm0
               	movl	$0xa, %r10d
               	movq	%r10, 0xc0(%rsp)
               	movq	0xc0(%rsp), %r11
               	vpinsrb	$0x6, %r11d, %xmm0, %xmm0
               	movl	$0xb, %r10d
               	movq	%r10, 0xc0(%rsp)
               	movq	0xc0(%rsp), %r11
               	vpinsrb	$0x7, %r11d, %xmm0, %xmm0
               	vmovq	%xmm0, %r10
               	movq	%r10, 0xc0(%rsp)
               	movq	0xc0(%rsp), %r10
               	movq	%r10, -0x20(%rbp)
               	leaq	-0x20(%rbp), %r10
               	movq	%r10, 0xc0(%rsp)
               	movabsq	$0x3ff4000000000000, %r10 # imm = 0x3FF4000000000000
               	movq	%r10, 0xb8(%rsp)
               	movl	$0x5, %r10d
               	movq	%r10, 0xb0(%rsp)
               	movq	0xb0(%rsp), %r11
               	vpinsrb	$0x0, %r11d, %xmm0, %xmm0
               	movl	$0x6, %r10d
               	movq	%r10, 0xb0(%rsp)
               	movq	0xb0(%rsp), %r11
               	vpinsrb	$0x1, %r11d, %xmm0, %xmm0
               	movl	$0x7, %r10d
               	movq	%r10, 0xb0(%rsp)
               	movq	0xb0(%rsp), %r11
               	vpinsrb	$0x2, %r11d, %xmm0, %xmm0
               	movl	$0x8, %r10d
               	movq	%r10, 0xb0(%rsp)
               	movq	0xb0(%rsp), %r11
               	vpinsrb	$0x3, %r11d, %xmm0, %xmm0
               	movl	$0x9, %r10d
               	movq	%r10, 0xb0(%rsp)
               	movq	0xb0(%rsp), %r11
               	vpinsrb	$0x4, %r11d, %xmm0, %xmm0
               	movl	$0xa, %r10d
               	movq	%r10, 0xb0(%rsp)
               	movq	0xb0(%rsp), %r11
               	vpinsrb	$0x5, %r11d, %xmm0, %xmm0
               	movl	$0xb, %r10d
               	movq	%r10, 0xb0(%rsp)
               	movq	0xb0(%rsp), %r11
               	vpinsrb	$0x6, %r11d, %xmm0, %xmm0
               	movl	$0xc, %r10d
               	movq	%r10, 0xb0(%rsp)
               	movq	0xb0(%rsp), %r11
               	vpinsrb	$0x7, %r11d, %xmm0, %xmm0
               	vmovq	%xmm0, %r10
               	movq	%r10, 0xb0(%rsp)
               	movq	0xb0(%rsp), %r10
               	movq	%r10, -0x18(%rbp)
               	leaq	-0x18(%rbp), %r10
               	movq	%r10, 0xb0(%rsp)
               	movabsq	$0x3ff8000000000000, %r10 # imm = 0x3FF8000000000000
               	movq	%r10, 0xa8(%rsp)
               	movl	$0x6, %r10d
               	movq	%r10, 0xa0(%rsp)
               	movq	0xa0(%rsp), %r11
               	vpinsrb	$0x0, %r11d, %xmm0, %xmm0
               	movl	$0x7, %r10d
               	movq	%r10, 0xa0(%rsp)
               	movq	0xa0(%rsp), %r11
               	vpinsrb	$0x1, %r11d, %xmm0, %xmm0
               	movl	$0x8, %r10d
               	movq	%r10, 0xa0(%rsp)
               	movq	0xa0(%rsp), %r11
               	vpinsrb	$0x2, %r11d, %xmm0, %xmm0
               	movl	$0x9, %r10d
               	movq	%r10, 0xa0(%rsp)
               	movq	0xa0(%rsp), %r11
               	vpinsrb	$0x3, %r11d, %xmm0, %xmm0
               	movl	$0xa, %r10d
               	movq	%r10, 0xa0(%rsp)
               	movq	0xa0(%rsp), %r11
               	vpinsrb	$0x4, %r11d, %xmm0, %xmm0
               	movl	$0xb, %r10d
               	movq	%r10, 0xa0(%rsp)
               	movq	0xa0(%rsp), %r11
               	vpinsrb	$0x5, %r11d, %xmm0, %xmm0
               	movl	$0xc, %r10d
               	movq	%r10, 0xa0(%rsp)
               	movq	0xa0(%rsp), %r11
               	vpinsrb	$0x6, %r11d, %xmm0, %xmm0
               	movl	$0xd, %r10d
               	movq	%r10, 0xa0(%rsp)
               	movq	0xa0(%rsp), %r11
               	vpinsrb	$0x7, %r11d, %xmm0, %xmm0
               	vmovq	%xmm0, %r10
               	movq	%r10, 0xa0(%rsp)
               	movq	0xa0(%rsp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	-0x8(%rbp), %r10
               	movq	%r10, 0xa0(%rsp)
               	subq	$0x20, %rsp
               	movq	0xd8(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0xc8(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0xd0(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0xc0(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rdx, %xmm0
               	movq	%rsi, %xmm2
               	movq	%rcx, %xmm4
               	movsd	0xe8(%rsp), %xmm6
               	movq	%r9, %r10
               	movsd	(%r10), %xmm1
               	movq	%rax, %r10
               	movsd	(%r10), %xmm3
               	movq	%r8, %r10
               	movsd	(%r10), %xmm5
               	movq	0xe0(%rsp), %r10
               	movsd	(%r10), %xmm7
               	movb	$0x8, %al
               	callq	<addr>
               	addq	$0x20, %rsp
               	movabsq	$0x4056500000000000, %rax # imm = 0x4056500000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
