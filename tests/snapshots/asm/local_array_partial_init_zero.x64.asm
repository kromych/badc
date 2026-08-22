
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
               	movl	$0xdeadbeef, %esi       # imm = 0xDEADBEEF
               	movl	%esi, (%rdx,%rcx,4)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x28, %rcx
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
               	movq	%rax, %rsi
               	jmp	<addr>
               	movl	%esi, %esi
               	movl	(%rcx,%rdx,4), %r8d
               	addq	%r8, %rsi
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x19, %rdx
               	jl	<addr>
               	movl	%esi, %r8d
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x12345678, %edx       # imm = 0x12345678
               	movl	%edx, (%rdi,%rcx,4)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x28, %rcx
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
               	movq	%rax, %rsi
               	jmp	<addr>
               	movl	%esi, %esi
               	movl	(%rcx,%rdx,4), %edi
               	addq	%rdi, %rsi
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x19, %rdx
               	jl	<addr>
               	movl	%esi, %ecx
               	movl	%r8d, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	%ecx, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
