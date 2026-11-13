
values_saved_around_calls.x64:	file format elf64-x86-64

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

<touch>:
               	movq	%rdi, %rax
               	xorq	$0x5a5a, %rax           # imm = 0x5A5A
               	retq

<scale>:
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	vfmadd132sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm0 * xmm15) + xmm14
               	retq

<swap>:
               	vpextrd	$0x3, %xmm0, %eax
               	movslq	%eax, %rax
               	vmovd	%eax, %xmm1
               	vpextrd	$0x2, %xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x1, %eax, %xmm1, %xmm1
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x2, %eax, %xmm1, %xmm1
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	retq

<ints>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, 0x78(%rsp)
               	movq	%rsi, 0x70(%rsp)
               	xorl	%ebx, %ebx
               	movq	0x78(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x78(%rsp), %r10
               	movq	0x8(%r10), %r10
               	movq	%r10, 0x80(%rsp)
               	movq	0x78(%rsp), %r10
               	movq	0x10(%r10), %r10
               	movq	%r10, 0x88(%rsp)
               	movq	0x78(%rsp), %r10
               	movq	0x18(%r10), %rdi
               	movq	0x78(%rsp), %r10
               	movq	0x20(%r10), %rsi
               	movq	0x78(%rsp), %r10
               	movq	0x28(%r10), %r9
               	movq	0x78(%rsp), %r10
               	movq	0x30(%r10), %r8
               	movq	0x78(%rsp), %r10
               	movq	0x38(%r10), %rdx
               	movq	0x78(%rsp), %r10
               	movq	0x40(%r10), %rcx
               	movq	0x78(%rsp), %r10
               	movq	0x48(%r10), %r15
               	movq	0x78(%rsp), %r10
               	movq	0x50(%r10), %r14
               	movq	0x78(%rsp), %r10
               	movq	0x58(%r10), %r13
               	movq	0x78(%rsp), %r10
               	movq	0x60(%r10), %r12
               	movq	0x78(%rsp), %r10
               	movq	0x68(%r10), %r10
               	movq	%r10, 0x78(%rsp)
               	jmp	<addr>
               	incq	%rbx
               	cmpl	0x70(%rsp), %ebx
               	jge	<addr>
               	addq	%rbx, %rax
               	movq	0x80(%rsp), %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x80(%rsp)
               	movq	0x88(%rsp), %r10
               	addq	0x80(%rsp), %r10
               	movq	%r10, 0x88(%rsp)
               	xorq	0x88(%rsp), %rdi
               	addq	%rdi, %rsi
               	xorq	%rsi, %r9
               	addq	%r9, %r8
               	xorq	%r8, %rdx
               	addq	%rdx, %rcx
               	xorq	%rcx, %r15
               	addq	%r15, %r14
               	xorq	%r14, %r13
               	addq	%r13, %r12
               	movq	0x78(%rsp), %r10
               	xorq	%r12, %r10
               	movq	%r10, 0x78(%rsp)
               	testb	$0x7, %bl
               	jne	<addr>
               	movq	%rdi, 0x30(%rsp)
               	movq	%rsi, 0x38(%rsp)
               	movq	%r9, 0x40(%rsp)
               	movq	%r8, 0x48(%rsp)
               	movq	%rdx, 0x50(%rsp)
               	movq	%rcx, 0x58(%rsp)
               	movq	%rax, %rdi
               	callq	<addr>
               	movq	0x30(%rsp), %rdi
               	movq	0x38(%rsp), %rsi
               	movq	0x40(%rsp), %r9
               	movq	0x48(%rsp), %r8
               	movq	0x50(%rsp), %rdx
               	movq	0x58(%rsp), %rcx
               	jmp	<addr>
               	addq	0x80(%rsp), %rax
               	addq	0x88(%rsp), %rax
               	addq	%rdi, %rax
               	addq	%rsi, %rax
               	addq	%r9, %rax
               	addq	%r8, %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r15, %rax
               	addq	%r14, %rax
               	addq	%r13, %rax
               	addq	%r12, %rax
               	addq	0x78(%rsp), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<ints_ref>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rsi, %r12
               	movq	(%rdi), %rax
               	movq	%rax, -0x70(%rbp)
               	movq	0x8(%rdi), %rax
               	movq	%rax, -0x68(%rbp)
               	movq	0x10(%rdi), %rax
               	movq	%rax, -0x60(%rbp)
               	movq	0x18(%rdi), %rax
               	movq	%rax, -0x58(%rbp)
               	movq	0x20(%rdi), %rax
               	movq	%rax, -0x50(%rbp)
               	movq	0x28(%rdi), %rax
               	movq	%rax, -0x48(%rbp)
               	movq	0x30(%rdi), %rax
               	movq	%rax, -0x40(%rbp)
               	movq	0x38(%rdi), %rax
               	movq	%rax, -0x38(%rbp)
               	movq	0x40(%rdi), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	0x48(%rdi), %rax
               	movq	%rax, -0x28(%rbp)
               	movq	0x50(%rdi), %rax
               	movq	%rax, -0x20(%rbp)
               	movq	0x58(%rdi), %rax
               	movq	%rax, -0x18(%rbp)
               	movq	0x60(%rdi), %rax
               	movq	%rax, -0x10(%rbp)
               	movq	0x68(%rdi), %rax
               	movq	%rax, -0x8(%rbp)
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	incq	%rbx
               	cmpl	%r12d, %ebx
               	jge	<addr>
               	addq	%rbx, -0x70(%rbp)
               	movl	$0x1, %eax
               	jmp	<addr>
               	movq	%rcx, -0x70(%rbp,%rax,8)
               	incq	%rax
               	cmpl	$0xe, %eax
               	jge	<addr>
               	testb	$0x1, %al
               	je	<addr>
               	movq	-0x70(%rbp,%rax,8), %rdi
               	leaq	-0x1(%rax), %r8
               	movq	-0x70(%rbp,%r8,8), %rcx
               	xorq	%rdi, %rcx
               	jmp	<addr>
               	movq	-0x70(%rbp,%rax,8), %rdi
               	leaq	-0x1(%rax), %r8
               	movq	-0x70(%rbp,%r8,8), %rcx
               	addq	%rdi, %rcx
               	jmp	<addr>
               	testb	$0x7, %bl
               	jne	<addr>
               	movq	-0x70(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x70(%rbp)
               	jmp	<addr>
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x60(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x58(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x50(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x48(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x40(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x38(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x30(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x28(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x20(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<doubles>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rsi, %r12
               	xorl	%ebx, %ebx
               	movsd	(%rdi), %xmm0
               	movsd	0x8(%rdi), %xmm10
               	movsd	0x10(%rdi), %xmm9
               	movsd	0x18(%rdi), %xmm8
               	movsd	0x20(%rdi), %xmm7
               	movsd	0x28(%rdi), %xmm6
               	movsd	0x30(%rdi), %xmm5
               	movsd	0x38(%rdi), %xmm4
               	movsd	0x40(%rdi), %xmm3
               	movsd	0x48(%rdi), %xmm2
               	movsd	0x50(%rdi), %xmm1
               	movsd	0x58(%rdi), %xmm11
               	jmp	<addr>
               	incq	%rbx
               	cmpl	%r12d, %ebx
               	jge	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	vaddsd	%xmm0, %xmm10, %xmm10
               	addsd	%xmm10, %xmm9
               	addsd	%xmm9, %xmm8
               	addsd	%xmm8, %xmm7
               	addsd	%xmm7, %xmm6
               	addsd	%xmm6, %xmm5
               	addsd	%xmm5, %xmm4
               	addsd	%xmm4, %xmm3
               	addsd	%xmm3, %xmm2
               	addsd	%xmm2, %xmm1
               	vaddsd	%xmm1, %xmm11, %xmm11
               	testb	$0x3, %bl
               	jne	<addr>
               	movsd	%xmm10, 0x18(%rsp)
               	movsd	%xmm9, 0x20(%rsp)
               	movsd	%xmm8, 0x28(%rsp)
               	movsd	%xmm7, 0x30(%rsp)
               	movsd	%xmm6, 0x38(%rsp)
               	movsd	%xmm5, 0x40(%rsp)
               	movsd	%xmm4, 0x48(%rsp)
               	movsd	%xmm3, 0x50(%rsp)
               	movsd	%xmm2, 0x58(%rsp)
               	movsd	%xmm1, 0x60(%rsp)
               	movsd	%xmm11, 0x68(%rsp)
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm10
               	movsd	0x20(%rsp), %xmm9
               	movsd	0x28(%rsp), %xmm8
               	movsd	0x30(%rsp), %xmm7
               	movsd	0x38(%rsp), %xmm6
               	movsd	0x40(%rsp), %xmm5
               	movsd	0x48(%rsp), %xmm4
               	movsd	0x50(%rsp), %xmm3
               	movsd	0x58(%rsp), %xmm2
               	movsd	0x60(%rsp), %xmm1
               	movsd	0x68(%rsp), %xmm11
               	jmp	<addr>
               	addsd	%xmm10, %xmm0
               	addsd	%xmm9, %xmm0
               	addsd	%xmm8, %xmm0
               	addsd	%xmm7, %xmm0
               	addsd	%xmm6, %xmm0
               	addsd	%xmm5, %xmm0
               	addsd	%xmm4, %xmm0
               	addsd	%xmm3, %xmm0
               	addsd	%xmm2, %xmm0
               	addsd	%xmm1, %xmm0
               	addsd	%xmm11, %xmm0
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<doubles_ref>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rsi, %r12
               	movsd	(%rdi), %xmm0
               	movsd	0x8(%rdi), %xmm1
               	movsd	0x10(%rdi), %xmm2
               	movsd	0x18(%rdi), %xmm3
               	movsd	0x20(%rdi), %xmm4
               	movsd	0x28(%rdi), %xmm5
               	movsd	0x30(%rdi), %xmm6
               	movsd	0x38(%rdi), %xmm7
               	movsd	0x40(%rdi), %xmm8
               	movsd	0x48(%rdi), %xmm9
               	movsd	0x50(%rdi), %xmm10
               	movsd	0x58(%rdi), %xmm11
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	incq	%rbx
               	cmpl	%r12d, %ebx
               	jge	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	addsd	%xmm0, %xmm1
               	addsd	%xmm1, %xmm2
               	addsd	%xmm2, %xmm3
               	addsd	%xmm3, %xmm4
               	addsd	%xmm4, %xmm5
               	addsd	%xmm5, %xmm6
               	addsd	%xmm6, %xmm7
               	vaddsd	%xmm7, %xmm8, %xmm8
               	addsd	%xmm8, %xmm9
               	addsd	%xmm9, %xmm10
               	addsd	%xmm10, %xmm11
               	testb	$0x3, %bl
               	jne	<addr>
               	movsd	%xmm1, 0x68(%rsp)
               	movsd	%xmm2, 0x60(%rsp)
               	movsd	%xmm3, 0x58(%rsp)
               	movsd	%xmm4, 0x50(%rsp)
               	movsd	%xmm5, 0x48(%rsp)
               	movsd	%xmm6, 0x40(%rsp)
               	movsd	%xmm7, 0x38(%rsp)
               	movsd	%xmm8, 0x30(%rsp)
               	movsd	%xmm9, 0x28(%rsp)
               	movsd	%xmm10, 0x20(%rsp)
               	movsd	%xmm11, 0x18(%rsp)
               	callq	<addr>
               	movsd	0x68(%rsp), %xmm1
               	movsd	0x60(%rsp), %xmm2
               	movsd	0x58(%rsp), %xmm3
               	movsd	0x50(%rsp), %xmm4
               	movsd	0x48(%rsp), %xmm5
               	movsd	0x40(%rsp), %xmm6
               	movsd	0x38(%rsp), %xmm7
               	movsd	0x30(%rsp), %xmm8
               	movsd	0x28(%rsp), %xmm9
               	movsd	0x20(%rsp), %xmm10
               	movsd	0x18(%rsp), %xmm11
               	jmp	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	vaddsd	%xmm0, %xmm14, %xmm0
               	addsd	%xmm1, %xmm0
               	addsd	%xmm2, %xmm0
               	addsd	%xmm3, %xmm0
               	addsd	%xmm4, %xmm0
               	addsd	%xmm5, %xmm0
               	addsd	%xmm6, %xmm0
               	addsd	%xmm7, %xmm0
               	addsd	%xmm8, %xmm0
               	addsd	%xmm9, %xmm0
               	addsd	%xmm10, %xmm0
               	addsd	%xmm11, %xmm0
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<vectors>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movups	%xmm0, -0x30(%rbp)
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	incq	%rbx
               	cmpl	%r12d, %ebx
               	jge	<addr>
               	leaq	-0x30(%rbp), %r9
               	vmovd	%ebx, %xmm0
               	movl	$0x1, %eax
               	vpinsrd	$0x1, %eax, %xmm0, %xmm0
               	movl	$0x2, %eax
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	movl	$0x3, %eax
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	movups	-0x30(%rbp), %xmm3
               	vpaddd	%xmm0, %xmm3, %xmm0
               	movups	%xmm0, -0x30(%rbp)
               	vpxor	%xmm0, %xmm1, %xmm1
               	vpaddd	%xmm1, %xmm2, %xmm2
               	testb	$0x1, %bl
               	jne	<addr>
               	movups	%xmm1, 0x20(%rsp)
               	movups	%xmm2, 0x30(%rsp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	0x20(%rsp), %xmm1
               	movups	0x30(%rsp), %xmm2
               	movups	%xmm0, -0x30(%rbp)
               	jmp	<addr>
               	movups	-0x30(%rbp), %xmm0
               	vpaddd	%xmm1, %xmm0, %xmm0
               	vpaddd	%xmm2, %xmm0, %xmm0
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x128, %rsp            # imm = 0x128
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	$0x3e8, -0x78(%rbp)     # imm = 0x3E8
               	movq	$0x40d, -0x70(%rbp)     # imm = 0x40D
               	movq	$0x432, -0x68(%rbp)     # imm = 0x432
               	movq	$0x457, -0x60(%rbp)     # imm = 0x457
               	movq	$0x47c, -0x58(%rbp)     # imm = 0x47C
               	movq	$0x4a1, -0x50(%rbp)     # imm = 0x4A1
               	movq	$0x4c6, -0x48(%rbp)     # imm = 0x4C6
               	movq	$0x4eb, -0x40(%rbp)     # imm = 0x4EB
               	movq	$0x510, -0x38(%rbp)     # imm = 0x510
               	movq	$0x535, -0x30(%rbp)     # imm = 0x535
               	movq	$0x55a, -0x28(%rbp)     # imm = 0x55A
               	movq	$0x57f, -0x20(%rbp)     # imm = 0x57F
               	movq	$0x5a4, -0x18(%rbp)     # imm = 0x5A4
               	movq	$0x5c9, -0x10(%rbp)     # imm = 0x5C9
               	movq	$0x0, -0xd8(%rbp)
               	movabsq	$0x3fd0000000000000, %rax # imm = 0x3FD0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0xd0(%rbp)
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0xc8(%rbp)
               	movabsq	$0x3fe8000000000000, %rax # imm = 0x3FE8000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0xc0(%rbp)
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0xb8(%rbp)
               	movabsq	$0x3ff4000000000000, %rax # imm = 0x3FF4000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0xb0(%rbp)
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0xa8(%rbp)
               	movabsq	$0x3ffc000000000000, %rax # imm = 0x3FFC000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0xa0(%rbp)
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x98(%rbp)
               	movabsq	$0x4002000000000000, %rax # imm = 0x4002000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x90(%rbp)
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x88(%rbp)
               	movabsq	$0x4006000000000000, %rax # imm = 0x4006000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x80(%rbp)
               	movl	$0x64, -0x8(%rbp)
               	leaq	-0x78(%rbp), %rdi
               	movl	-0x8(%rbp), %esi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	-0x78(%rbp), %rdi
               	movl	-0x8(%rbp), %esi
               	callq	<addr>
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	-0xd8(%rbp), %rdi
               	movl	-0x8(%rbp), %esi
               	callq	<addr>
               	movsd	%xmm0, 0x58(%rsp)
               	leaq	-0xd8(%rbp), %rdi
               	movl	-0x8(%rbp), %esi
               	callq	<addr>
               	movsd	0x58(%rsp), %xmm14
               	ucomisd	%xmm0, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	-0x120(%rbp), %r9
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	-0x110(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x100(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movl	-0x8(%rbp), %edi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	callq	<addr>
               	movups	-0x120(%rbp), %xmm1
               	movups	-0x110(%rbp), %xmm3
               	movups	-0x100(%rbp), %xmm2
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	movl	-0x8(%rbp), %ecx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	vmovd	%xmm1, %ecx
               	movslq	%ecx, %rcx
               	addq	%rax, %rcx
               	movapd	%xmm1, %xmm4
               	vpinsrd	$0x0, %ecx, %xmm4, %xmm4
               	vpextrd	$0x1, %xmm1, %edx
               	movslq	%edx, %rdx
               	incq	%rdx
               	vpinsrd	$0x1, %edx, %xmm4, %xmm4
               	vpextrd	$0x2, %xmm1, %esi
               	movslq	%esi, %rsi
               	addq	$0x2, %rsi
               	vpinsrd	$0x2, %esi, %xmm4, %xmm4
               	vpextrd	$0x3, %xmm1, %edi
               	movslq	%edi, %rdi
               	addq	$0x3, %rdi
               	movapd	%xmm4, %xmm1
               	vpinsrd	$0x3, %edi, %xmm1, %xmm1
               	vmovd	%xmm3, %r8d
               	movslq	%r8d, %r8
               	xorq	%rcx, %r8
               	movapd	%xmm3, %xmm4
               	vpinsrd	$0x0, %r8d, %xmm4, %xmm4
               	vpextrd	$0x1, %xmm3, %r9d
               	movslq	%r9d, %r9
               	xorq	%rdx, %r9
               	vpinsrd	$0x1, %r9d, %xmm4, %xmm4
               	vpextrd	$0x2, %xmm3, %ebx
               	movslq	%ebx, %rbx
               	xorq	%rsi, %rbx
               	vpinsrd	$0x2, %ebx, %xmm4, %xmm4
               	vpextrd	$0x3, %xmm3, %r12d
               	movslq	%r12d, %r12
               	xorq	%rdi, %r12
               	movapd	%xmm4, %xmm3
               	vpinsrd	$0x3, %r12d, %xmm3, %xmm3
               	vmovd	%xmm2, %r13d
               	movslq	%r13d, %r13
               	addq	%r13, %r8
               	movapd	%xmm2, %xmm4
               	vpinsrd	$0x0, %r8d, %xmm4, %xmm4
               	vpextrd	$0x1, %xmm2, %r8d
               	movslq	%r8d, %r8
               	addq	%r9, %r8
               	vpinsrd	$0x1, %r8d, %xmm4, %xmm4
               	vpextrd	$0x2, %xmm2, %r8d
               	movslq	%r8d, %r8
               	addq	%rbx, %r8
               	vpinsrd	$0x2, %r8d, %xmm4, %xmm4
               	vpextrd	$0x3, %xmm2, %r8d
               	movslq	%r8d, %r8
               	addq	%r12, %r8
               	movapd	%xmm4, %xmm2
               	vpinsrd	$0x3, %r8d, %xmm2, %xmm2
               	testb	$0x1, %al
               	jne	<addr>
               	vmovd	%edi, %xmm1
               	vpinsrd	$0x1, %esi, %xmm1, %xmm1
               	vpinsrd	$0x2, %edx, %xmm1, %xmm1
               	vpinsrd	$0x3, %ecx, %xmm1, %xmm1
               	jmp	<addr>
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vmovd	%xmm1, %ecx
               	movslq	%ecx, %rcx
               	vmovd	%xmm3, %edx
               	movslq	%edx, %rdx
               	addq	%rdx, %rcx
               	vmovd	%xmm2, %edx
               	movslq	%edx, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	vpextrd	$0x1, %xmm1, %ecx
               	movslq	%ecx, %rcx
               	vpextrd	$0x1, %xmm3, %edx
               	movslq	%edx, %rdx
               	addq	%rdx, %rcx
               	vpextrd	$0x1, %xmm2, %edx
               	movslq	%edx, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrd	$0x2, %xmm0, %eax
               	movslq	%eax, %rax
               	vpextrd	$0x2, %xmm1, %ecx
               	movslq	%ecx, %rcx
               	vpextrd	$0x2, %xmm3, %edx
               	movslq	%edx, %rdx
               	addq	%rdx, %rcx
               	vpextrd	$0x2, %xmm2, %edx
               	movslq	%edx, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %eax
               	movslq	%eax, %rax
               	vpextrd	$0x3, %xmm1, %ecx
               	movslq	%ecx, %rcx
               	vpextrd	$0x3, %xmm3, %edx
               	movslq	%edx, %rdx
               	addq	%rdx, %rcx
               	vpextrd	$0x3, %xmm2, %edx
               	movslq	%edx, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
