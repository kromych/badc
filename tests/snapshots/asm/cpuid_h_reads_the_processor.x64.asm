
cpuid_h_reads_the_processor.x64:	file format elf64-x86-64

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
               	subq	$0x58, %rsp
               	pushq	%rbx
               	xorl	%eax, %eax
               	movl	%eax, -0x28(%rbp)
               	movq	%rax, %rcx
               	cpuid
               	movq	%rax, %rsi
               	movq	%rbx, %rdi
               	leaq	-0x28(%rbp), %r9
               	xorl	%eax, %eax
               	cpuid
               	movq	%rax, %r8
               	testq	%r9, %r9
               	je	<addr>
               	movl	%ebx, -0x28(%rbp)
               	testl	%r8d, %r8d
               	je	<addr>
               	cmpl	%esi, %r8d
               	jne	<addr>
               	movl	-0x28(%rbp), %eax
               	cmpl	%edi, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	cpuid
               	movl	%ebx, -0x38(%rbp)
               	movl	%ecx, -0x30(%rbp)
               	movl	%edx, -0x8(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	leaq	-0x38(%rbp), %rax
               	movl	(%rax), %r10d
               	movl	%r10d, (%rcx)
               	leaq	0x4(%rcx), %rax
               	leaq	-0x8(%rbp), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rax)
               	leaq	0x8(%rcx), %rax
               	leaq	-0x30(%rbp), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rax)
               	movb	%sil, -0x14(%rbp)
               	movsbq	-0x20(%rbp,%rsi), %rdx
               	cmpl	$0x20, %edx
               	jl	<addr>
               	movsbq	-0x20(%rbp,%rsi), %rdx
               	cmpl	$0x7e, %edx
               	jg	<addr>
               	incq	%rsi
               	cmpl	$0xc, %esi
               	jl	<addr>
               	leaq	-0x20(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movq	%r8, 0x18(%rsp)
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movq	0x18(%rsp), %r8
               	leaq	-0x20(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movq	%r8, 0x18(%rsp)
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x18(%rsp), %r8
               	testq	%rbx, %rbx
               	jne	<addr>
               	movl	-0x38(%rbp), %ecx
               	cmpl	$0x756e6547, %ecx       # imm = 0x756E6547
               	jne	<addr>
               	movl	-0x30(%rbp), %ecx
               	cmpl	$0x6c65746e, %ecx       # imm = 0x6C65746E
               	jne	<addr>
               	movl	-0x8(%rbp), %ecx
               	cmpl	$0x49656e69, %ecx       # imm = 0x49656E69
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x38(%rbp), %eax
               	cmpl	$0x68747541, %eax       # imm = 0x68747541
               	jne	<addr>
               	movl	-0x30(%rbp), %eax
               	cmpl	$0x444d4163, %eax       # imm = 0x444D4163
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x69746e65, %eax       # imm = 0x69746E65
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	xorl	%ecx, %ecx
               	cpuid
               	movq	%rax, %rdi
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	cpuid
               	movq	%rax, %rsi
               	cmpl	$0x80000001, %esi       # imm = 0x80000001
               	jb	<addr>
               	cmpl	%edi, %esi
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movq	%rcx, %rdi
               	movq	%rdx, %r9
               	xorl	%eax, %eax
               	cpuid
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	cpuid
               	movl	%ebx, -0x38(%rbp)
               	movl	%ecx, -0x30(%rbp)
               	movl	%edx, -0x8(%rbp)
               	movl	-0x30(%rbp), %eax
               	cmpl	%edi, %eax
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	cmpl	%r9d, %eax
               	jne	<addr>
               	testl	$0x4000000, %eax        # imm = 0x4000000
               	jne	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	cpuid
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x80000001, %eax       # imm = 0x80000001
               	jae	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x80000001, %eax       # imm = 0x80000001
               	cpuid
               	movl	%ebx, -0x38(%rbp)
               	movl	%ecx, -0x30(%rbp)
               	movl	%edx, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	testl	$0x20000000, %eax       # imm = 0x20000000
               	je	<addr>
               	leaq	0x1(%r8), %rdi
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	andq	%rdi, %rax
               	cpuid
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	%edi, %eax
               	jae	<addr>
               	incq	%rsi
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	andq	%rsi, %rax
               	cpuid
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	%esi, %eax
               	jae	<addr>
               	cmpl	$0x7, %r8d
               	jb	<addr>
               	movl	$0x7, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movq	%rbx, %rsi
               	movq	%rcx, %rdi
               	xorl	%eax, %eax
               	cpuid
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x7, %eax
               	jae	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%ebx, -0x38(%rbp)
               	movl	%ecx, -0x30(%rbp)
               	movl	%edx, -0x8(%rbp)
               	movl	-0x38(%rbp), %eax
               	cmpl	%esi, %eax
               	jne	<addr>
               	movl	-0x30(%rbp), %eax
               	cmpl	%edi, %eax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	leaq	0x4(%rax), %rdi
               	leaq	0x8(%rax), %r8
               	leaq	0xc(%rax), %r9
               	movl	$0x7, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%eax, -0x10(%rbp)
               	movl	%ebx, (%rdi)
               	movl	%ecx, (%r8)
               	movl	%edx, (%r9)
               	movl	-0xc(%rbp), %eax
               	cmpl	%esi, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	%esi, %eax
               	cpuid
               	movl	%ebx, -0x38(%rbp)
               	movl	%ecx, -0x30(%rbp)
               	movl	%edx, -0x8(%rbp)
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	%edi, %eax
               	cpuid
               	movl	%ebx, -0x38(%rbp)
               	movl	%ecx, -0x30(%rbp)
               	movl	%edx, -0x8(%rbp)
               	jmp	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
