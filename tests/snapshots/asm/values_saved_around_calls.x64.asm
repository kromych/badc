
values_saved_around_calls.x64:	file format elf64-x86-64

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

<touch>:
               	xorq	$0x5a5a, %rdi           # imm = 0x5A5A
               	movq	%rdi, %rax
               	retq

<scale>:
               	movsd	<rip>, %xmm1
               	movsd	<rip>, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
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
               	subq	$0x58, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	%rdi, %r10
               	movq	%rsi, 0x68(%rsp)
               	xorl	%ebx, %ebx
               	movq	(%r10), %rax
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x78(%rsp)
               	movq	0x10(%r10), %rdi
               	movq	0x18(%r10), %rsi
               	movq	0x20(%r10), %r9
               	movq	0x28(%r10), %r8
               	movq	0x30(%r10), %rdx
               	movq	0x38(%r10), %rcx
               	movq	0x40(%r10), %rbp
               	movq	0x48(%r10), %r15
               	movq	0x50(%r10), %r14
               	movq	0x58(%r10), %r13
               	movq	0x60(%r10), %r12
               	movq	0x68(%r10), %r11
               	movq	%r11, 0x70(%rsp)
               	jmp	<addr>
               	incq	%rbx
               	nop
               	cmpl	0x68(%rsp), %ebx
               	jge	<addr>
               	addq	%rbx, %rax
               	movq	0x78(%rsp), %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x78(%rsp)
               	addq	0x78(%rsp), %rdi
               	xorq	%rdi, %rsi
               	addq	%rsi, %r9
               	xorq	%r9, %r8
               	addq	%r8, %rdx
               	xorq	%rdx, %rcx
               	addq	%rcx, %rbp
               	xorq	%rbp, %r15
               	addq	%r15, %r14
               	xorq	%r14, %r13
               	addq	%r13, %r12
               	movq	0x70(%rsp), %r10
               	xorq	%r12, %r10
               	movq	%r10, 0x70(%rsp)
               	testb	$0x7, %bl
               	jne	<addr>
               	movq	%rdi, 0x38(%rsp)
               	movq	%rsi, 0x40(%rsp)
               	movq	%r9, 0x48(%rsp)
               	movq	%r8, 0x50(%rsp)
               	movq	%rdx, 0x58(%rsp)
               	movq	%rcx, 0x60(%rsp)
               	movq	%rax, %rdi
               	callq	<addr>
               	movq	0x38(%rsp), %rdi
               	movq	0x40(%rsp), %rsi
               	movq	0x48(%rsp), %r9
               	movq	0x50(%rsp), %r8
               	movq	0x58(%rsp), %rdx
               	movq	0x60(%rsp), %rcx
               	jmp	<addr>
               	addq	0x78(%rsp), %rax
               	addq	%rdi, %rax
               	addq	%rsi, %rax
               	addq	%r9, %rax
               	addq	%r8, %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%rbp, %rax
               	addq	%r15, %rax
               	addq	%r14, %rax
               	addq	%r13, %rax
               	addq	%r12, %rax
               	addq	0x70(%rsp), %rax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x58, %rsp
               	retq

<ints_ref>:
               	subq	$0x78, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rsi, %r12
               	movq	(%rdi), %rax
               	movq	%rax, 0x10(%rsp)
               	movq	0x8(%rdi), %rax
               	movq	%rax, 0x18(%rsp)
               	movq	0x10(%rdi), %rax
               	movq	%rax, 0x20(%rsp)
               	movq	0x18(%rdi), %rax
               	movq	%rax, 0x28(%rsp)
               	movq	0x20(%rdi), %rax
               	movq	%rax, 0x30(%rsp)
               	movq	0x28(%rdi), %rax
               	movq	%rax, 0x38(%rsp)
               	movq	0x30(%rdi), %rax
               	movq	%rax, 0x40(%rsp)
               	movq	0x38(%rdi), %rax
               	movq	%rax, 0x48(%rsp)
               	movq	0x40(%rdi), %rax
               	movq	%rax, 0x50(%rsp)
               	movq	0x48(%rdi), %rax
               	movq	%rax, 0x58(%rsp)
               	movq	0x50(%rdi), %rax
               	movq	%rax, 0x60(%rsp)
               	movq	0x58(%rdi), %rax
               	movq	%rax, 0x68(%rsp)
               	movq	0x60(%rdi), %rax
               	movq	%rax, 0x70(%rsp)
               	movq	0x68(%rdi), %rax
               	movq	%rax, 0x78(%rsp)
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	incq	%rbx
               	cmpl	%r12d, %ebx
               	jge	<addr>
               	addq	%rbx, 0x10(%rsp)
               	movl	$0x1, %eax
               	jmp	<addr>
               	movq	%rcx, 0x10(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0xe, %eax
               	jge	<addr>
               	testb	$0x1, %al
               	je	<addr>
               	movq	0x10(%rsp,%rax,8), %rcx
               	leaq	-0x1(%rax), %rdi
               	movq	0x10(%rsp,%rdi,8), %rdi
               	xorq	%rdi, %rcx
               	jmp	<addr>
               	movq	0x10(%rsp,%rax,8), %rdi
               	leaq	-0x1(%rax), %r8
               	movq	0x10(%rsp,%r8,8), %rcx
               	addq	%rdi, %rcx
               	jmp	<addr>
               	nopw	(%rax,%rax)
               	testb	$0x7, %bl
               	jne	<addr>
               	movq	0x10(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, 0x10(%rsp)
               	jmp	<addr>
               	movq	0x10(%rsp), %rax
               	movq	0x18(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x20(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x28(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x30(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x38(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x48(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x50(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x58(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x60(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x68(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x70(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x78(%rsp), %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	addq	$0x78, %rsp
               	retq

<doubles>:
               	subq	$0x68, %rsp
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
               	vaddsd	<rip>, %xmm0, %xmm0
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
               	addq	$0x68, %rsp
               	retq

<doubles_ref>:
               	subq	$0x68, %rsp
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
               	vaddsd	<rip>, %xmm0, %xmm0
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
               	xorps	%xmm12, %xmm12
               	vaddsd	%xmm0, %xmm12, %xmm0
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
               	addq	$0x68, %rsp
               	retq

<vectors>:
               	subq	$0x38, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movups	%xmm0, 0x10(%rsp)
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	incq	%rbx
               	cmpl	%r12d, %ebx
               	jge	<addr>
               	leaq	0x10(%rsp), %r9
               	vmovd	%ebx, %xmm0
               	movl	$0x1, %eax
               	vpinsrd	$0x1, %eax, %xmm0, %xmm0
               	movl	$0x2, %eax
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	movl	$0x3, %eax
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	movups	0x10(%rsp), %xmm3
               	vpaddd	%xmm0, %xmm3, %xmm0
               	movups	%xmm0, 0x10(%rsp)
               	vpxor	%xmm0, %xmm1, %xmm1
               	vpaddd	%xmm1, %xmm2, %xmm2
               	nop
               	testb	$0x1, %bl
               	jne	<addr>
               	movups	%xmm1, 0x20(%rsp)
               	movups	%xmm2, 0x30(%rsp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	0x20(%rsp), %xmm1
               	movups	0x30(%rsp), %xmm2
               	movups	%xmm0, 0x10(%rsp)
               	jmp	<addr>
               	movups	0x10(%rsp), %xmm0
               	vpaddd	%xmm1, %xmm0, %xmm0
               	vpaddd	%xmm2, %xmm0, %xmm0
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq

<main>:
               	subq	$0x140, %rsp            # imm = 0x140
               	pushq	%rbx
               	movq	$0x3e8, 0xc8(%rsp)      # imm = 0x3E8
               	movq	$0x40d, 0xd0(%rsp)      # imm = 0x40D
               	movq	$0x432, 0xd8(%rsp)      # imm = 0x432
               	movq	$0x457, 0xe0(%rsp)      # imm = 0x457
               	movq	$0x47c, 0xe8(%rsp)      # imm = 0x47C
               	movq	$0x4a1, 0xf0(%rsp)      # imm = 0x4A1
               	movq	$0x4c6, 0xf8(%rsp)      # imm = 0x4C6
               	movq	$0x4eb, 0x100(%rsp)     # imm = 0x4EB
               	movq	$0x510, 0x108(%rsp)     # imm = 0x510
               	movq	$0x535, 0x110(%rsp)     # imm = 0x535
               	movq	$0x55a, 0x118(%rsp)     # imm = 0x55A
               	movq	$0x57f, 0x120(%rsp)     # imm = 0x57F
               	movq	$0x5a4, 0x128(%rsp)     # imm = 0x5A4
               	movq	$0x5c9, 0x130(%rsp)     # imm = 0x5C9
               	movq	$0x0, 0x68(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x70(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x78(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x80(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x88(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x90(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x98(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0xa0(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0xa8(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0xb0(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0xb8(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0xc0(%rsp)
               	movl	$0x64, 0x138(%rsp)
               	movl	0x138(%rsp), %esi
               	leaq	0xc8(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	0x138(%rsp), %esi
               	leaq	0xc8(%rsp), %rdi
               	callq	<addr>
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0x140, %rsp            # imm = 0x140
               	retq
               	movl	0x138(%rsp), %esi
               	leaq	0x68(%rsp), %rdi
               	callq	<addr>
               	movsd	%xmm0, 0x58(%rsp)
               	movl	0x138(%rsp), %esi
               	leaq	0x68(%rsp), %rdi
               	callq	<addr>
               	movsd	0x58(%rsp), %xmm14
               	ucomisd	%xmm0, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0x140, %rsp            # imm = 0x140
               	retq
               	leaq	0x10(%rsp), %r9
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	0x20(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x30(%rsp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movl	0x138(%rsp), %edi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	callq	<addr>
               	movups	0x10(%rsp), %xmm1
               	movups	0x20(%rsp), %xmm3
               	movups	0x30(%rsp), %xmm2
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	movl	0x138(%rsp), %ecx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	vmovd	%xmm1, %ecx
               	movslq	%ecx, %rcx
               	leaq	(%rcx,%rax), %r8
               	movapd	%xmm1, %xmm4
               	vpinsrd	$0x0, %r8d, %xmm4, %xmm4
               	vpextrd	$0x1, %xmm1, %ecx
               	movslq	%ecx, %rcx
               	leaq	0x1(%rcx), %r9
               	vpinsrd	$0x1, %r9d, %xmm4, %xmm4
               	vpextrd	$0x2, %xmm1, %ecx
               	movslq	%ecx, %rcx
               	leaq	0x2(%rcx), %r10
               	movq	%r9, 0x48(%rsp)
               	vpinsrd	$0x2, %r10d, %xmm4, %xmm4
               	vpextrd	$0x3, %xmm1, %ecx
               	movslq	%ecx, %rcx
               	leaq	0x3(%rcx), %r11
               	movapd	%xmm4, %xmm1
               	vpinsrd	$0x3, %r11d, %xmm1, %xmm1
               	vmovd	%xmm3, %ecx
               	movslq	%ecx, %rcx
               	xorq	%r8, %rcx
               	movapd	%xmm3, %xmm4
               	vpinsrd	$0x0, %ecx, %xmm4, %xmm4
               	vpextrd	$0x1, %xmm3, %edx
               	movslq	%edx, %rdx
               	movq	0x48(%rsp), %r9
               	xorq	%r9, %rdx
               	movq	%r11, 0x48(%rsp)
               	vpinsrd	$0x1, %edx, %xmm4, %xmm4
               	vpextrd	$0x2, %xmm3, %esi
               	movslq	%esi, %rsi
               	movq	0x48(%rsp), %r11
               	xorq	%r10, %rsi
               	movq	%r11, 0x48(%rsp)
               	vpinsrd	$0x2, %esi, %xmm4, %xmm4
               	vpextrd	$0x3, %xmm3, %edi
               	movslq	%edi, %rdi
               	movq	0x48(%rsp), %r11
               	xorq	%r11, %rdi
               	movq	%r11, 0x48(%rsp)
               	movapd	%xmm4, %xmm3
               	vpinsrd	$0x3, %edi, %xmm3, %xmm3
               	vmovd	%xmm2, %ebx
               	movslq	%ebx, %rbx
               	addq	%rbx, %rcx
               	movapd	%xmm2, %xmm4
               	vpinsrd	$0x0, %ecx, %xmm4, %xmm4
               	vpextrd	$0x1, %xmm2, %ecx
               	movslq	%ecx, %rcx
               	addq	%rdx, %rcx
               	vpinsrd	$0x1, %ecx, %xmm4, %xmm4
               	vpextrd	$0x2, %xmm2, %ecx
               	movslq	%ecx, %rcx
               	addq	%rsi, %rcx
               	vpinsrd	$0x2, %ecx, %xmm4, %xmm4
               	vpextrd	$0x3, %xmm2, %ecx
               	movslq	%ecx, %rcx
               	addq	%rdi, %rcx
               	movapd	%xmm4, %xmm2
               	vpinsrd	$0x3, %ecx, %xmm2, %xmm2
               	testb	$0x1, %al
               	movq	0x48(%rsp), %r11
               	jne	<addr>
               	movq	%r9, 0x48(%rsp)
               	vmovd	%r11d, %xmm1
               	vpinsrd	$0x1, %r10d, %xmm1, %xmm1
               	movq	0x48(%rsp), %r9
               	vpinsrd	$0x2, %r9d, %xmm1, %xmm1
               	vpinsrd	$0x3, %r8d, %xmm1, %xmm1
               	nop
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
               	addq	$0x140, %rsp            # imm = 0x140
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
               	addq	$0x140, %rsp            # imm = 0x140
               	retq
