
stat_and_at_functions_have_their_posix_types.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x100, %rsp            # imm = 0x100
               	pushq	%rbx
               	leaq	0x38(%rsp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	0x10(%rax), %r10d
               	movl	%r10d, 0x10(%rdi)
               	leaq	0x50(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0x100, %rsp            # imm = 0x100
               	retq
               	leaq	0x38(%rsp), %rdi
               	xorl	%esi, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jl	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x1c0, %edx            # imm = 0x1C0
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x180, %edx            # imm = 0x180
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0x100, %rsp            # imm = 0x100
               	retq
               	leaq	<rip>, %rsi
               	movl	$0x41, %edx
               	movl	$0x180, %ecx            # imm = 0x180
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rcx
               	testl	%ecx, %ecx
               	jl	<addr>
               	leaq	0x50(%rsp), %rsi
               	movq	%rcx, 0x10(%rsp)
               	movq	%rcx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x10(%rsp), %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1a0, %esi            # imm = 0x1A0
               	movq	%rcx, 0x10(%rsp)
               	movq	%rcx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x10(%rsp), %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rcx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	addq	$0x100, %rsp            # imm = 0x100
               	retq
               	leaq	<rip>, %rsi
               	leaq	0x70(%rsp), %rdx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0x88(%rsp), %eax
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	cmpl	$0x1a0, %eax            # imm = 0x1A0
               	jne	<addr>
               	movq	0xc8(%rsp), %rax
               	cmpq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	addq	$0x100, %rsp            # imm = 0x100
               	retq
               	leaq	<rip>, %rsi
               	leaq	0x50(%rsp), %rdx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x1e8, %edx            # imm = 0x1E8
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	addq	$0x100, %rsp            # imm = 0x100
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rdx
               	movq	%rbx, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rsi
               	leaq	0x28(%rsp), %rdx
               	movl	$0x10, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x4, %rax
               	jne	<addr>
               	leaq	0x28(%rsp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	addq	$0x100, %rsp            # imm = 0x100
               	retq
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rcx
               	xorl	%r8d, %r8d
               	movq	%rbx, %rdi
               	movq	%rbx, %rdx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rcx
               	movq	%rbx, %rdi
               	movq	%rbx, %rdx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rsi
               	leaq	0x70(%rsp), %rdx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x80(%rsp), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	addq	$0x100, %rsp            # imm = 0x100
               	retq
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	callq	<addr>
               	movq	%rax, %rcx
               	xorl	%r8d, %r8d
               	leaq	<rip>, %rsi
               	movq	%rbx, %rdi
               	movq	0x18(%rsp), %rdx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	addq	$0x100, %rsp            # imm = 0x100
               	retq
               	movq	<rip>, %rsi # <addr>
               	xorl	%edx, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	addq	$0x100, %rsp            # imm = 0x100
               	retq
               	movq	<rip>, %rsi # <addr>
               	xorl	%edx, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	xorl	%edx, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	xorl	%edx, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x12, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	<addr>
               	cmpl	$0x12, %eax
               	jne	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x200, %edx            # imm = 0x200
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	addq	$0x100, %rsp            # imm = 0x100
               	retq
               	leaq	0x38(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xb, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	cmoveq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	addq	$0x100, %rsp            # imm = 0x100
               	retq
