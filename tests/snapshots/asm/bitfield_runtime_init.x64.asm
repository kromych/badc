
bitfield_runtime_init.x64:	file format elf64-x86-64

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

<build_packed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movslq	%r8d, %r8
               	movslq	%r9d, %r9
               	leaq	-0x8(%rbp), %rcx
               	xorq	%rax, %rax
               	movq	%rax, (%rcx)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rcx
               	andq	$0xf, %rcx
               	orq	$0x0, %rcx
               	movl	%ecx, (%rdx)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rsi, %rbx
               	andq	$0xf, %rbx
               	movl	%ecx, %ecx
               	andq	$-0xf1, %rcx
               	shlq	$0x4, %rbx
               	orq	%rbx, %rcx
               	movl	%ecx, (%rdx)
               	leaq	-0x8(%rbp), %rbx
               	movq	%r8, %rdx
               	andq	$0x1f, %rdx
               	movl	%ecx, %ecx
               	andq	$-0x1f01, %rcx          # imm = 0xE0FF
               	movq	%rdx, %r12
               	shlq	$0x8, %r12
               	orq	%r12, %rcx
               	movl	%ecx, (%rbx)
               	leaq	-0x8(%rbp), %rdx
               	movq	%r9, %rbx
               	andq	$0xfffff, %rbx          # imm = 0xFFFFF
               	orq	$0x0, %rbx
               	movl	%ebx, 0x4(%rdx)
               	movl	%ecx, %edx
               	andq	$0xf, %rdx
               	andq	$0xf, %rdi
               	xorq	%rdi, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	%ecx, %eax
               	sarq	$0x4, %rax
               	andq	$0xf, %rax
               	movq	%rsi, %rdx
               	andq	$0xf, %rdx
               	xorq	%rdx, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%rdx, %rdx
               	testq	%rax, %rax
               	je	<addr>
               	movl	%ecx, %eax
               	sarq	$0x8, %rax
               	andq	$0x1f, %rax
               	shlq	$0x3b, %rax
               	sarq	$0x3b, %rax
               	cmpq	%r8, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rax, %rax
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	%ebx, %eax
               	andq	$0xfffff, %rax          # imm = 0xFFFFF
               	movq	%r9, %rcx
               	andq	$0xfffff, %rcx          # imm = 0xFFFFF
               	xorq	%rcx, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<build_mixed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdx, %r9
               	movq	%rcx, %rbx
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movslq	%r9d, %r9
               	movslq	%ebx, %rbx
               	movslq	%r8d, %r8
               	leaq	-0x10(%rbp), %rcx
               	xorq	%rax, %rax
               	movq	%rax, (%rcx)
               	movl	%eax, 0x8(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movw	%di, (%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movq	%rsi, %rdx
               	andq	$0x7, %rdx
               	movl	(%rcx), %r12d
               	andq	$-0x70001, %r12         # imm = 0xFFF8FFFF
               	shlq	$0x10, %rdx
               	orq	%r12, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movq	%r9, %r12
               	andq	$0x3ff, %r12            # imm = 0x3FF
               	movl	%edx, %edx
               	andq	$-0x1ff80001, %rdx      # imm = 0xE007FFFF
               	shlq	$0x13, %r12
               	orq	%r12, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movq	%rbx, %r12
               	andq	$0x7ffff, %r12          # imm = 0x7FFFF
               	orq	$0x0, %r12
               	movl	%r12d, 0x4(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movl	%r8d, 0x8(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movzwq	(%rcx), %rcx
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	cmpq	%rdi, %rcx
               	jne	<addr>
               	movl	%edx, %eax
               	sarq	$0x10, %rax
               	andq	$0x7, %rax
               	movq	%rsi, %rcx
               	andq	$0x7, %rcx
               	xorq	%rcx, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movl	%edx, %eax
               	sarq	$0x13, %rax
               	andq	$0x3ff, %rax            # imm = 0x3FF
               	movq	%r9, %rcx
               	andq	$0x3ff, %rcx            # imm = 0x3FF
               	xorq	%rcx, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rdx, %rdx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	%r12d, %eax
               	andq	$0x7ffff, %rax          # imm = 0x7FFFF
               	movq	%rbx, %rcx
               	andq	$0x7ffff, %rcx          # imm = 0x7FFFF
               	xorq	%rcx, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rax, %rax
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	%r8d, %rax
               	cmpq	%r8, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %edi
               	movl	$0xa, %esi
               	movabsq	$-0x3, %rdx
               	movl	$0x12345, %ecx          # imm = 0x12345
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0xff, %edi
               	movl	$0x1f, %esi
               	movl	$0xf, %edx
               	movl	$0xfffffff, %ecx        # imm = 0xFFFFFFF
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movabsq	$-0x10, %rdx
               	movq	%rdi, %rsi
               	movq	%rdi, %rcx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x1234, %edi           # imm = 0x1234
               	movl	$0x6, %esi
               	movl	$0x1f4, %edx            # imm = 0x1F4
               	movl	$0x186a0, %ecx          # imm = 0x186A0
               	movabsq	$-0x4d, %r8
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0xffff, %edi           # imm = 0xFFFF
               	movl	$0x7, %esi
               	movl	$0x3ff, %edx            # imm = 0x3FF
               	movl	$0x7ffff, %ecx          # imm = 0x7FFFF
               	movl	$0x7fffffff, %r8d       # imm = 0x7FFFFFFF
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
