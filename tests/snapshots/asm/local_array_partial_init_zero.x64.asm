
local_array_partial_init_zero.x64:	file format elf64-x86-64

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
               	subq	$0xb0, %rsp
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xa8(%rbp), %rdx
               	movslq	%eax, %rcx
               	movl	$0xdeadbeef, %esi       # imm = 0xDEADBEEF
               	movl	%esi, (%rdx,%rcx,4)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x28, %eax
               	jl	<addr>
               	leaq	-0xa8(%rbp), %rdi
               	movl	(%rdi), %eax
               	movl	0x9c(%rdi), %ecx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	leaq	-0x70(%rbp), %rcx
               	xorq	%rax, %rax
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	movq	%rax, 0x10(%rcx)
               	movq	%rax, 0x18(%rcx)
               	movq	%rax, 0x20(%rcx)
               	movq	%rax, 0x28(%rcx)
               	movq	%rax, 0x30(%rcx)
               	movq	%rax, 0x38(%rcx)
               	movq	%rax, 0x40(%rcx)
               	movq	%rax, 0x48(%rcx)
               	movq	%rax, 0x50(%rcx)
               	movq	%rax, 0x58(%rcx)
               	movl	%eax, 0x60(%rcx)
               	movq	%rax, %rdx
               	jmp	<addr>
               	movl	%edx, %edx
               	movslq	%eax, %rsi
               	movl	(%rcx,%rsi,4), %r8d
               	addq	%r8, %rdx
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x19, %eax
               	jl	<addr>
               	movl	%edx, %r8d
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movl	$0x12345678, %edx       # imm = 0x12345678
               	movl	%edx, (%rdi,%rcx,4)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x28, %eax
               	jl	<addr>
               	leaq	-0xa8(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	0x9c(%rax), %eax
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	leaq	-0x70(%rbp), %rcx
               	xorq	%rax, %rax
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	movq	%rax, 0x10(%rcx)
               	movq	%rax, 0x18(%rcx)
               	movq	%rax, 0x20(%rcx)
               	movq	%rax, 0x28(%rcx)
               	movq	%rax, 0x30(%rcx)
               	movq	%rax, 0x38(%rcx)
               	movq	%rax, 0x40(%rcx)
               	movq	%rax, 0x48(%rcx)
               	movq	%rax, 0x50(%rcx)
               	movq	%rax, 0x58(%rcx)
               	movl	%eax, 0x60(%rcx)
               	movq	%rax, %rdx
               	jmp	<addr>
               	movl	%edx, %edx
               	movslq	%eax, %rsi
               	movl	(%rcx,%rsi,4), %edi
               	addq	%rdi, %rdx
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x19, %eax
               	jl	<addr>
               	movl	%edx, %ecx
               	movl	%r8d, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	%ecx, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
