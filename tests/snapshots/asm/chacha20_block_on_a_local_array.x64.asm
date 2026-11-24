
chacha20_block_on_a_local_array.x64:	file format elf64-x86-64

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

<chacha_block>:
               	subq	$0x88, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	%rdi, 0x40(%rsp)
               	leaq	0x70(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rsi), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	movups	0x30(%rsi), %xmm14
               	movups	%xmm14, 0x30(%rax)
               	xorl	%eax, %eax
               	movl	0x70(%rsp), %ecx
               	movl	0x80(%rsp), %edx
               	addq	%rdx, %rcx
               	movl	0xa0(%rsp), %edx
               	movl	%ecx, %edi
               	xorq	%rdi, %rdx
               	rorl	$0x10, %edx
               	movl	0x90(%rsp), %edi
               	leaq	(%rdi,%rdx), %r8
               	movl	0x80(%rsp), %edi
               	movl	%r8d, %r9d
               	xorq	%r9, %rdi
               	rorxl	$0x14, %edi, %r9d
               	addq	%r9, %rcx
               	movl	%edx, %edx
               	movl	%ecx, %edi
               	xorq	%rdi, %rdx
               	rorl	$0x18, %edx
               	addq	%rdx, %r8
               	movl	%r9d, %edi
               	movl	%r8d, %r9d
               	xorq	%r9, %rdi
               	rorxl	$0x19, %edi, %r9d
               	movl	0x74(%rsp), %edi
               	movl	0x84(%rsp), %ebx
               	addq	%rbx, %rdi
               	movl	0xa4(%rsp), %ebx
               	movl	%edi, %r12d
               	xorq	%r12, %rbx
               	rorl	$0x10, %ebx
               	movl	0x94(%rsp), %r12d
               	addq	%rbx, %r12
               	movl	0x84(%rsp), %r13d
               	movl	%r12d, %r14d
               	xorq	%r14, %r13
               	rorl	$0x14, %r13d
               	addq	%r13, %rdi
               	movl	%ebx, %ebx
               	movl	%edi, %r14d
               	xorq	%r14, %rbx
               	rorl	$0x18, %ebx
               	addq	%rbx, %r12
               	movl	%r13d, %r13d
               	movl	%r12d, %r14d
               	xorq	%r14, %r13
               	rorl	$0x19, %r13d
               	movl	0x78(%rsp), %r14d
               	movl	0x88(%rsp), %r15d
               	addq	%r15, %r14
               	movl	0xa8(%rsp), %r15d
               	movl	%r14d, %ebp
               	xorq	%rbp, %r15
               	rorl	$0x10, %r15d
               	movl	0x98(%rsp), %ebp
               	addq	%r15, %rbp
               	movl	0x88(%rsp), %r10d
               	movq	%r10, 0x68(%rsp)
               	movl	%ebp, %r10d
               	movq	%r10, 0x60(%rsp)
               	movq	0x68(%rsp), %r10
               	xorq	0x60(%rsp), %r10
               	movq	%r10, 0x68(%rsp)
               	rorl	$0x14, %r10d
               	movq	%r10, 0x68(%rsp)
               	addq	0x68(%rsp), %r14
               	movl	%r15d, %r15d
               	movl	%r14d, %r10d
               	movq	%r10, 0x60(%rsp)
               	xorq	0x60(%rsp), %r15
               	rorl	$0x18, %r15d
               	addq	%r15, %rbp
               	movq	0x68(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x68(%rsp)
               	movl	%ebp, %r10d
               	movq	%r10, 0x60(%rsp)
               	movq	0x68(%rsp), %r10
               	xorq	0x60(%rsp), %r10
               	movq	%r10, 0x68(%rsp)
               	rorl	$0x19, %r10d
               	movq	%r10, 0x68(%rsp)
               	movl	0x7c(%rsp), %r10d
               	movq	%r10, 0x60(%rsp)
               	movl	0x8c(%rsp), %r10d
               	movq	%r10, 0x58(%rsp)
               	movq	0x60(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	movl	0xac(%rsp), %r10d
               	movq	%r10, 0x58(%rsp)
               	movq	0x60(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x50(%rsp)
               	movq	0x58(%rsp), %r10
               	xorq	0x50(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	rorl	$0x10, %r10d
               	movq	%r10, 0x58(%rsp)
               	movl	0x9c(%rsp), %r10d
               	movq	%r10, 0x50(%rsp)
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movl	0x8c(%rsp), %r10d
               	movq	%r10, 0x48(%rsp)
               	movq	0x50(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x38(%rsp)
               	movq	0x48(%rsp), %r10
               	xorq	0x38(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	rorl	$0x14, %r10d
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rsp), %r10
               	addq	0x48(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x58(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x58(%rsp)
               	movq	0x60(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x38(%rsp)
               	movq	0x58(%rsp), %r10
               	xorq	0x38(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	rorl	$0x18, %r10d
               	movq	%r10, 0x58(%rsp)
               	movq	0x50(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x48(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x48(%rsp)
               	movq	0x50(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x38(%rsp)
               	movq	0x48(%rsp), %r10
               	xorq	0x38(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	rorl	$0x19, %r10d
               	movq	%r10, 0x48(%rsp)
               	addq	%r13, %rcx
               	movq	0x58(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x58(%rsp)
               	movl	%ecx, %r10d
               	movq	%r10, 0x38(%rsp)
               	movq	0x58(%rsp), %r10
               	xorq	0x38(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	rorl	$0x10, %r10d
               	movq	%r10, 0x58(%rsp)
               	addq	0x58(%rsp), %rbp
               	movl	%r13d, %r13d
               	movl	%ebp, %r10d
               	movq	%r10, 0x38(%rsp)
               	xorq	0x38(%rsp), %r13
               	rorl	$0x14, %r13d
               	addq	%r13, %rcx
               	movl	%ecx, 0x70(%rsp)
               	movq	0x58(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x58(%rsp)
               	movl	%ecx, %ecx
               	movq	%rcx, %r10
               	movq	0x58(%rsp), %rcx
               	xorq	%r10, %rcx
               	rorl	$0x18, %ecx
               	movl	%ecx, 0xac(%rsp)
               	addq	%rbp, %rcx
               	movl	%ecx, 0x98(%rsp)
               	movl	%r13d, %r13d
               	movl	%ecx, %ecx
               	xorq	%r13, %rcx
               	rorl	$0x19, %ecx
               	movl	%ecx, 0x84(%rsp)
               	movq	%rdi, %rcx
               	addq	0x68(%rsp), %rcx
               	movl	%edx, %edx
               	movl	%ecx, %edi
               	xorq	%rdi, %rdx
               	rorl	$0x10, %edx
               	movq	0x50(%rsp), %rdi
               	addq	%rdx, %rdi
               	movq	0x68(%rsp), %r13
               	movl	%r13d, %r13d
               	movl	%edi, %ebp
               	xorq	%rbp, %r13
               	rorl	$0x14, %r13d
               	addq	%r13, %rcx
               	movl	%ecx, 0x74(%rsp)
               	movl	%edx, %edx
               	movl	%ecx, %ecx
               	xorq	%rdx, %rcx
               	rorl	$0x18, %ecx
               	movl	%ecx, 0xa0(%rsp)
               	addq	%rdi, %rcx
               	movl	%ecx, 0x9c(%rsp)
               	movl	%r13d, %edx
               	movl	%ecx, %ecx
               	xorq	%rdx, %rcx
               	rorl	$0x19, %ecx
               	movl	%ecx, 0x88(%rsp)
               	movq	%r14, %rcx
               	addq	0x48(%rsp), %rcx
               	movl	%ebx, %edx
               	movl	%ecx, %edi
               	xorq	%rdi, %rdx
               	rorl	$0x10, %edx
               	addq	%rdx, %r8
               	movq	0x48(%rsp), %rdi
               	movl	%edi, %edi
               	movl	%r8d, %ebx
               	xorq	%rbx, %rdi
               	rorl	$0x14, %edi
               	addq	%rdi, %rcx
               	movl	%ecx, 0x78(%rsp)
               	movl	%edx, %edx
               	movl	%ecx, %ecx
               	xorq	%rdx, %rcx
               	rorl	$0x18, %ecx
               	movl	%ecx, 0xa4(%rsp)
               	addq	%r8, %rcx
               	movl	%ecx, 0x90(%rsp)
               	movl	%edi, %edx
               	movl	%ecx, %ecx
               	xorq	%rdx, %rcx
               	rorl	$0x19, %ecx
               	movl	%ecx, 0x8c(%rsp)
               	movq	0x60(%rsp), %rcx
               	addq	%r9, %rcx
               	movl	%r15d, %edx
               	movl	%ecx, %edi
               	xorq	%rdi, %rdx
               	rorl	$0x10, %edx
               	leaq	(%r12,%rdx), %r8
               	movl	%r9d, %edi
               	movl	%r8d, %r9d
               	xorq	%r9, %rdi
               	rorxl	$0x14, %edi, %r9d
               	addq	%r9, %rcx
               	movl	%ecx, 0x7c(%rsp)
               	movl	%edx, %edx
               	movl	%ecx, %ecx
               	xorq	%rdx, %rcx
               	rorl	$0x18, %ecx
               	movl	%ecx, 0xa8(%rsp)
               	addq	%r8, %rcx
               	movl	%ecx, 0x94(%rsp)
               	movl	%r9d, %edx
               	movl	%ecx, %ecx
               	xorq	%rdx, %rcx
               	rorl	$0x19, %ecx
               	movl	%ecx, 0x80(%rsp)
               	incq	%rax
               	cmpl	$0xa, %eax
               	jl	<addr>
               	movl	0x70(%rsp), %eax
               	movl	(%rsi), %ecx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %r10
               	movl	%eax, (%r10)
               	movl	0x74(%rsp), %eax
               	movl	0x4(%rsi), %ecx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %r10
               	movl	%eax, 0x4(%r10)
               	movl	0x78(%rsp), %eax
               	movl	0x8(%rsi), %ecx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %r10
               	movl	%eax, 0x8(%r10)
               	movl	0x7c(%rsp), %eax
               	movl	0xc(%rsi), %ecx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %r10
               	movl	%eax, 0xc(%r10)
               	movl	0x80(%rsp), %eax
               	movl	0x10(%rsi), %ecx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %r10
               	movl	%eax, 0x10(%r10)
               	movl	0x84(%rsp), %eax
               	movl	0x14(%rsi), %ecx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %r10
               	movl	%eax, 0x14(%r10)
               	movl	0x88(%rsp), %eax
               	movl	0x18(%rsi), %ecx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %r10
               	movl	%eax, 0x18(%r10)
               	movl	0x8c(%rsp), %eax
               	movl	0x1c(%rsi), %ecx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %r10
               	movl	%eax, 0x1c(%r10)
               	movl	0x90(%rsp), %eax
               	movl	0x20(%rsi), %ecx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %r10
               	movl	%eax, 0x20(%r10)
               	movl	0x94(%rsp), %eax
               	movl	0x24(%rsi), %ecx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %r10
               	movl	%eax, 0x24(%r10)
               	movl	0x98(%rsp), %eax
               	movl	0x28(%rsi), %ecx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %r10
               	movl	%eax, 0x28(%r10)
               	movl	0x9c(%rsp), %eax
               	movl	0x2c(%rsi), %ecx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %r10
               	movl	%eax, 0x2c(%r10)
               	movl	0xa0(%rsp), %eax
               	movl	0x30(%rsi), %ecx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %r10
               	movl	%eax, 0x30(%r10)
               	movl	0xa4(%rsp), %eax
               	movl	0x34(%rsi), %ecx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %r10
               	movl	%eax, 0x34(%r10)
               	movl	0xa8(%rsp), %eax
               	movl	0x38(%rsi), %ecx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %r10
               	movl	%eax, 0x38(%r10)
               	movl	0xac(%rsp), %eax
               	movl	0x3c(%rsi), %ecx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %r10
               	movl	%eax, 0x3c(%r10)
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x88, %rsp
               	retq

<main>:
               	subq	$0x48, %rsp
               	leaq	(%rsp), %rdi
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	xorl	%eax, %eax
               	movl	(%rsp), %ecx
               	cmpl	$0xe4e7f110, %ecx       # imm = 0xE4E7F110
               	je	<addr>
               	incq	%rax
               	addq	$0x48, %rsp
               	retq
               	movl	$0x1, %eax
               	movl	0x4(%rsp), %ecx
               	cmpl	$0x15593bd1, %ecx       # imm = 0x15593BD1
               	jne	<addr>
               	movl	$0x2, %eax
               	movl	0x8(%rsp), %ecx
               	cmpl	$0x1fdd0f50, %ecx       # imm = 0x1FDD0F50
               	jne	<addr>
               	movl	$0x3, %eax
               	movl	0xc(%rsp), %ecx
               	cmpl	$0xc47120a3, %ecx       # imm = 0xC47120A3
               	jne	<addr>
               	movl	$0x4, %eax
               	movl	0x10(%rsp), %ecx
               	cmpl	$0xc7f4d1c7, %ecx       # imm = 0xC7F4D1C7
               	jne	<addr>
               	movl	$0x5, %eax
               	movl	0x14(%rsp), %ecx
               	cmpl	$0x368c033, %ecx        # imm = 0x368C033
               	jne	<addr>
               	movl	$0x6, %eax
               	movl	0x18(%rsp), %ecx
               	cmpl	$0x9aaa2204, %ecx       # imm = 0x9AAA2204
               	jne	<addr>
               	movl	$0x7, %eax
               	movl	0x1c(%rsp), %ecx
               	cmpl	$0x4e6cd4c3, %ecx       # imm = 0x4E6CD4C3
               	jne	<addr>
               	movl	$0x8, %eax
               	movl	0x20(%rsp), %ecx
               	cmpl	$0x466482d2, %ecx       # imm = 0x466482D2
               	jne	<addr>
               	movl	$0x9, %eax
               	movl	0x24(%rsp), %ecx
               	cmpl	$0x9aa9f07, %ecx        # imm = 0x9AA9F07
               	jne	<addr>
               	movl	$0xa, %eax
               	movl	0x28(%rsp), %ecx
               	cmpl	$0x5d7c214, %ecx        # imm = 0x5D7C214
               	jne	<addr>
               	movl	$0xb, %eax
               	movl	0x2c(%rsp), %ecx
               	cmpl	$0xa2028bd9, %ecx       # imm = 0xA2028BD9
               	jne	<addr>
               	movl	$0xc, %eax
               	movl	0x30(%rsp), %ecx
               	cmpl	$0xd19c12b5, %ecx       # imm = 0xD19C12B5
               	jne	<addr>
               	movl	$0xd, %eax
               	movl	0x34(%rsp), %ecx
               	cmpl	$0xb94e16de, %ecx       # imm = 0xB94E16DE
               	jne	<addr>
               	movl	$0xe, %eax
               	movl	0x38(%rsp), %ecx
               	cmpl	$0xe883d0cb, %ecx       # imm = 0xE883D0CB
               	jne	<addr>
               	movl	$0xf, %eax
               	movl	0x3c(%rsp), %ecx
               	cmpl	$0x4e3c50a2, %ecx       # imm = 0x4E3C50A2
               	jne	<addr>
               	xorl	%eax, %eax
               	addq	$0x48, %rsp
               	retq
