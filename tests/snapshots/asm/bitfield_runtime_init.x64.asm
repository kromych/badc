
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
               	movq	%r13, 0x10(%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movslq	%r8d, %r8
               	movq	%rdi, %rax
               	andq	$0xf, %rax
               	movq	%rax, %rcx
               	orq	$0x0, %rcx
               	movq	%rsi, %rbx
               	andq	$0xf, %rbx
               	movq	%rbx, %rdx
               	shlq	$0x4, %rdx
               	orq	%rcx, %rdx
               	movq	%r8, %rcx
               	andq	$0x1f, %rcx
               	movl	%edx, %edx
               	andq	$-0x1f01, %rdx          # imm = 0xE0FF
               	movq	%rcx, %r12
               	shlq	$0x8, %r12
               	orq	%r12, %rdx
               	movq	%r9, %rcx
               	andq	$0xfffff, %rcx          # imm = 0xFFFFF
               	movq	%rcx, %r12
               	orq	$0x0, %r12
               	movl	%edx, %r13d
               	movq	%r13, %rcx
               	andq	$0xf, %rcx
               	xorq	%rcx, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%r13, %rax
               	sarq	$0x4, %rax
               	andq	$0xf, %rax
               	xorq	%rbx, %rax
               	testl	%eax, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	%edx, %ecx
               	sarq	$0x8, %rcx
               	andq	$0x1f, %rcx
               	shlq	$0x3b, %rcx
               	sarq	$0x3b, %rcx
               	cmpq	%r8, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%r9, %rax
               	andq	$0xfffff, %rax          # imm = 0xFFFFF
               	xorq	%r12, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>

<build_mixed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%rsi, %r9
               	movq	%rcx, %r12
               	movq	%rdx, %rbx
               	movslq	%r9d, %r9
               	movslq	%ebx, %rbx
               	leaq	-0x10(%rbp), %rax
               	movq	$0x0, (%rax)
               	movl	$0x0, 0x8(%rax)
               	movw	%di, (%rax)
               	movq	%r9, %rcx
               	andq	$0x7, %rcx
               	movl	(%rax), %edx
               	andq	$-0x70001, %rdx         # imm = 0xFFF8FFFF
               	movq	%rcx, %rsi
               	shlq	$0x10, %rsi
               	orq	%rsi, %rdx
               	movl	%edx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%rbx, %r13
               	andq	$0x3ff, %r13            # imm = 0x3FF
               	movl	%edx, %edx
               	andq	$-0x1ff80001, %rdx      # imm = 0xE007FFFF
               	movq	%r13, %rsi
               	shlq	$0x13, %rsi
               	orq	%rsi, %rdx
               	movl	%edx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%r12, %rsi
               	andq	$0x7ffff, %rsi          # imm = 0x7FFFF
               	orq	$0x0, %rsi
               	movl	%esi, 0x4(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	%r8d, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movzwq	(%rax), %rax
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	cmpl	%edi, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	xorq	%rax, %rax
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	%edx, %eax
               	sarq	$0x10, %rax
               	andq	$0x7, %rax
               	xorq	%rcx, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movl	%edx, %eax
               	sarq	$0x13, %rax
               	andq	$0x3ff, %rax            # imm = 0x3FF
               	xorq	%r13, %rax
               	testl	%eax, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%r12, %rcx
               	andq	$0x7ffff, %rcx          # imm = 0x7FFFF
               	xorq	%rsi, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpl	%r8d, %r8d
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	jmp	<addr>
               	movq	%rax, %rcx
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
