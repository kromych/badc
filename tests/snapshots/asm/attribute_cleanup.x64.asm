
attribute_cleanup.x64:	file format elf64-x86-64

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

<loopy>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x32, -0x10(%rbp)
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx      # <addr>
               	leaq	<rip>, %rcx      # <addr>
               	movl	%eax, -0x8(%rbp)
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	-0x8(%rbp), %edi
               	movslq	(%rcx), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rcx)
               	movl	%edi, (%rdx,%rsi,4)
               	jmp	<addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	-0x8(%rbp), %edi
               	movslq	(%rcx), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rcx)
               	movl	%edi, (%rdx,%rsi,4)
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movl	-0x10(%rbp), %edx
               	leaq	<rip>, %rsi      # <addr>
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	%edx, (%rsi,%rcx,4)
               	leave
               	retq
               	movl	-0x8(%rbp), %edx
               	leaq	<rip>, %rsi      # <addr>
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	%edx, (%rsi,%rcx,4)
               	jmp	<addr>

<nested>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movslq	%edi, %rdi
               	movl	$0xa, -0x18(%rbp)
               	movl	$0xb, -0x10(%rbp)
               	movl	$0xc, -0x8(%rbp)
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	-0x8(%rbp), %esi
               	leaq	<rip>, %rcx      # <addr>
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	movl	-0x10(%rbp), %esi
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	movl	-0x18(%rbp), %esi
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	movl	$0x3e7, %eax            # imm = 0x3E7
               	leave
               	retq
               	movl	-0x8(%rbp), %esi
               	leaq	<rip>, %rcx      # <addr>
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	movl	-0x10(%rbp), %esi
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	movl	-0x18(%rbp), %esi
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	xorl	%eax, %eax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	<rip>, %rax      # <addr>
               	movl	$0x0, (%rax)
               	movl	$0x1, -0x18(%rbp)
               	movl	$0x2, -0x10(%rbp)
               	movl	$0x3, %ecx
               	movl	%ecx, -0x8(%rbp)
               	movq	%rcx, %rsi
               	leaq	<rip>, %rcx      # <addr>
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	movl	-0x10(%rbp), %esi
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	movl	-0x18(%rbp), %esi
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	movl	(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx      # <addr>
               	movl	(%rcx), %edx
               	cmpl	$0x3, %edx
               	jne	<addr>
               	movl	0x4(%rcx), %edx
               	cmpl	$0x2, %edx
               	jne	<addr>
               	movl	0x8(%rcx), %edx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rsi      # <addr>
               	movl	$0x1, (%rsi)
               	movl	$0x0, -0x8(%rbp)
               	movl	(%rsi), %edi
               	movl	$0x0, (%rsi)
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r9
               	movl	%r9d, (%rax)
               	movl	$0x2bc, (%rcx,%rsi,4)   # imm = 0x2BC
               	cmpl	$0x1, %edi
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx      # <addr>
               	movl	(%rcx), %ecx
               	cmpl	$0x2bc, %ecx            # imm = 0x2BC
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x0, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rcx      # <addr>
               	movl	(%rcx), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	0x4(%rax), %edx
               	cmpl	$0x1, %edx
               	jne	<addr>
               	movl	0x8(%rax), %edx
               	cmpl	$0x2, %edx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	cmpl	$0x32, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x0, (%rcx)
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x3e7, %eax            # imm = 0x3E7
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movl	(%rcx), %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %edx
               	cmpl	$0xc, %edx
               	jne	<addr>
               	movl	0x4(%rax), %edx
               	cmpl	$0xb, %edx
               	jne	<addr>
               	movl	0x8(%rax), %eax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	movl	%edi, (%rcx)
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx      # <addr>
               	movl	(%rcx), %edx
               	cmpl	$0xc, %edx
               	jne	<addr>
               	movl	0x4(%rcx), %edx
               	cmpl	$0xb, %edx
               	jne	<addr>
               	movl	0x8(%rcx), %edx
               	cmpl	$0xa, %edx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x0, (%rax)
               	movl	$0x28, -0x10(%rbp)
               	movl	$0x29, %esi
               	movl	%esi, -0x8(%rbp)
               	movq	%rsi, %rdi
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rax)
               	movl	%edi, (%rcx,%rsi,4)
               	leaq	-0x10(%rbp), %rsi
               	movl	(%rsi), %r8d
               	movslq	(%rax), %rdi
               	leaq	0x1(%rdi), %r9
               	movl	%r9d, (%rax)
               	movl	%r8d, (%rcx,%rdi,4)
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx      # <addr>
               	movl	(%rcx), %edi
               	cmpl	$0x29, %edi
               	jne	<addr>
               	movl	0x4(%rcx), %edi
               	cmpl	$0x28, %edi
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movl	$0x0, (%rax)
               	movl	$0x28, -0x10(%rbp)
               	movl	$0x29, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movl	(%rdx), %r8d
               	movslq	(%rax), %rdi
               	leaq	0x1(%rdi), %r9
               	movl	%r9d, (%rax)
               	movl	%r8d, (%rcx,%rdi,4)
               	movl	(%rsi), %edi
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rax)
               	movl	%edi, (%rcx,%rsi,4)
               	movl	(%rax), %ecx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx      # <addr>
               	movl	(%rcx), %esi
               	cmpl	$0x29, %esi
               	jne	<addr>
               	movl	0x4(%rcx), %esi
               	cmpl	$0x28, %esi
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movl	$0x0, (%rax)
               	movl	$0x14, -0x10(%rbp)
               	movl	$0x15, -0x8(%rbp)
               	movl	(%rdx), %esi
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	leaq	-0x10(%rbp), %rdx
               	movl	(%rdx), %edi
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rax)
               	movl	%edi, (%rcx,%rsi,4)
               	movl	(%rax), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx      # <addr>
               	movl	(%rcx), %eax
               	cmpl	$0x15, %eax
               	jne	<addr>
               	movl	0x4(%rcx), %eax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	$0x0, (%rax)
               	movl	$0x14, -0x10(%rbp)
               	movl	$0x15, %esi
               	movl	%esi, -0x8(%rbp)
               	movq	%rsi, %rdi
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rax)
               	movl	%edi, (%rcx,%rsi,4)
               	movl	(%rdx), %esi
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x15, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %eax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
