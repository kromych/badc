
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
               	pushq	%r12
               	pushq	%rbx
               	movq	%rsi, %r8
               	movq	%rcx, %rbx
               	movq	%rdx, %r9
               	movq	%rdi, %rax
               	andq	$0xf, %rax
               	movq	%r8, %r12
               	andq	$0xf, %r12
               	movq	%r12, %rcx
               	shlq	$0x4, %rcx
               	orq	%rax, %rcx
               	movq	%r9, %rsi
               	andq	$0x1f, %rsi
               	andq	$-0x1f01, %rcx          # imm = 0xE0FF
               	movq	%rsi, %rdx
               	shlq	$0x8, %rdx
               	orq	%rcx, %rdx
               	movq	%rbx, %rcx
               	andq	$0xfffff, %rcx          # imm = 0xFFFFF
               	movq	%rdx, %rsi
               	andq	$0xf, %rsi
               	xorq	%rsi, %rax
               	xorl	%esi, %esi
               	testl	%eax, %eax
               	jne	<addr>
               	movl	%edx, %eax
               	sarq	$0x4, %rax
               	andq	$0xf, %rax
               	xorq	%r12, %rax
               	testl	%eax, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	%edx, %edx
               	sarq	$0x8, %rdx
               	andq	$0x1f, %rdx
               	shlq	$0x3b, %rdx
               	sarq	$0x3b, %rdx
               	cmpl	%r9d, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rcx, %rax
               	xorq	%rcx, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%rax, %rdx
               	jmp	<addr>

<build_mixed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rsi, %r9
               	movq	%rcx, %r12
               	movq	%rdx, %rbx
               	leaq	-0x10(%rbp), %rax
               	movq	$0x0, (%rax)
               	movl	$0x0, 0x8(%rax)
               	movw	%di, (%rax)
               	movq	%r9, %rdx
               	andq	$0x7, %rdx
               	movl	(%rax), %ecx
               	andq	$-0x70001, %rcx         # imm = 0xFFF8FFFF
               	movq	%rdx, %rsi
               	shlq	$0x10, %rsi
               	orq	%rsi, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%rbx, %r13
               	andq	$0x3ff, %r13            # imm = 0x3FF
               	andq	$-0x1ff80001, %rcx      # imm = 0xE007FFFF
               	movq	%r13, %rsi
               	shlq	$0x13, %rsi
               	orq	%rcx, %rsi
               	movl	%esi, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%r12, %rcx
               	andq	$0x7ffff, %rcx          # imm = 0x7FFFF
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	%r8d, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movzwq	(%rax), %rax
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	cmpl	%edi, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	%esi, %eax
               	sarq	$0x10, %rax
               	andq	$0x7, %rax
               	xorq	%rdx, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	je	<addr>
               	movl	%esi, %eax
               	sarq	$0x13, %rax
               	andq	$0x3ff, %rax            # imm = 0x3FF
               	xorq	%r13, %rax
               	testl	%eax, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%r12, %rdx
               	andq	$0x7ffff, %rdx          # imm = 0x7FFFF
               	xorq	%rdx, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpl	%r8d, %r8d
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %edi
               	movl	$0xa, %esi
               	movq	$-0x3, %rdx
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
               	xorl	%edi, %edi
               	movq	$-0x10, %rdx
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
               	movq	$-0x4d, %r8
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
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
