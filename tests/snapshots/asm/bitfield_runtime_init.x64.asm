
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
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movslq	%r8d, %r8
               	leaq	-0x8(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rdi, %rbx
               	andq	$0xf, %rbx
               	movq	%rbx, %rdx
               	orq	$0x0, %rdx
               	movl	%edx, (%rax)
               	movq	%rsi, %r12
               	andq	$0xf, %r12
               	movl	%edx, %edx
               	andq	$-0xf1, %rdx
               	shlq	$0x4, %r12
               	orq	%r12, %rdx
               	movl	%edx, (%rax)
               	leaq	-0x8(%rbp), %r12
               	movq	%r8, %rax
               	andq	$0x1f, %rax
               	movl	%edx, %edx
               	andq	$-0x1f01, %rdx          # imm = 0xE0FF
               	movq	%rax, %r13
               	shlq	$0x8, %r13
               	orq	%r13, %rdx
               	movl	%edx, (%r12)
               	leaq	-0x8(%rbp), %rax
               	movq	%r9, %r12
               	andq	$0xfffff, %r12          # imm = 0xFFFFF
               	orq	$0x0, %r12
               	movl	%r12d, 0x4(%rax)
               	movl	%edx, %eax
               	movq	%rax, %r13
               	andq	$0xf, %r13
               	movq	%r13, %rdi
               	xorq	%rbx, %rdi
               	movl	%edi, %edi
               	testq	%rdi, %rdi
               	jne	<addr>
               	sarq	$0x4, %rax
               	andq	$0xf, %rax
               	movq	%rsi, %rcx
               	andq	$0xf, %rcx
               	xorq	%rcx, %rax
               	movl	%eax, %eax
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
               	movl	%r12d, %eax
               	andq	$0xfffff, %rax          # imm = 0xFFFFF
               	movq	%r9, %rcx
               	andq	$0xfffff, %rcx          # imm = 0xFFFFF
               	xorq	%rcx, %rax
               	movl	%eax, %eax
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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%rdx, %r9
               	movq	%rcx, %rbx
               	movslq	%esi, %rsi
               	movslq	%r9d, %r9
               	leaq	-0x10(%rbp), %rcx
               	xorq	%rax, %rax
               	movq	%rax, (%rcx)
               	movl	%eax, 0x8(%rcx)
               	movw	%di, (%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movq	%rsi, %r12
               	andq	$0x7, %r12
               	movl	(%rcx), %edx
               	andq	$-0x70001, %rdx         # imm = 0xFFF8FFFF
               	movq	%r12, %r13
               	shlq	$0x10, %r13
               	orq	%r13, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movq	%r9, %r13
               	andq	$0x3ff, %r13            # imm = 0x3FF
               	movl	%edx, %edx
               	andq	$-0x1ff80001, %rdx      # imm = 0xE007FFFF
               	shlq	$0x13, %r13
               	orq	%r13, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movq	%rbx, %r13
               	andq	$0x7ffff, %r13          # imm = 0x7FFFF
               	orq	$0x0, %r13
               	movl	%r13d, 0x4(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movl	%r8d, 0x8(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movzwq	(%rcx), %rcx
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	cmpl	%edi, %ecx
               	jne	<addr>
               	movl	%edx, %eax
               	sarq	$0x10, %rax
               	andq	$0x7, %rax
               	xorq	%r12, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movl	%edx, %eax
               	sarq	$0x13, %rax
               	andq	$0x3ff, %rax            # imm = 0x3FF
               	movq	%r9, %rdx
               	andq	$0x3ff, %rdx            # imm = 0x3FF
               	xorq	%rdx, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	%r13d, %eax
               	andq	$0x7ffff, %rax          # imm = 0x7FFFF
               	movq	%rbx, %rcx
               	andq	$0x7ffff, %rcx          # imm = 0x7FFFF
               	xorq	%rcx, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
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
               	jmp	<addr>
               	movq	%rcx, %rax
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
