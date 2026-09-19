
narrow_phi_reads.x64:	file format elf64-x86-64

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

<mix>:
               	leaq	(%rdi,%rdi,2), %rax
               	incq	%rax
               	movslq	%eax, %rax
               	retq

<join_masked>:
               	xorl	%eax, %eax
               	movl	%edi, %ecx
               	cmpl	$0x80, %ecx
               	jae	<addr>
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	xorq	$0x2a, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	retq

<loop_masked>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r13
               	xorl	%ebx, %ebx
               	movq	%rbx, %r12
               	cmpl	%r13d, %ebx
               	jge	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	%r12, %rax
               	movq	%rax, %r12
               	andq	$0xff, %r12
               	incq	%rbx
               	cmpl	%r13d, %ebx
               	jl	<addr>
               	movq	%r12, %rax
               	xorq	$0x2a, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<count_u8>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%edi, %eax
               	jge	<addr>
               	incq	%rcx
               	andq	$0xff, %rcx
               	incq	%rax
               	cmpl	%edi, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	retq

<count_s8>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%edi, %eax
               	jge	<addr>
               	addq	$0x3, %rcx
               	movq	%rcx, %rdx
               	movsbq	%dl, %rcx
               	incq	%rax
               	cmpl	%edi, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<join_u16>:
               	movl	$0x7, %eax
               	cmpl	$0x3e8, %edi            # imm = 0x3E8
               	jle	<addr>
               	movq	%rdi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	incq	%rax
               	movslq	%eax, %rax
               	retq

<join_unmasked>:
               	movq	%rsi, %rax
               	xorl	%esi, %esi
               	testl	%edi, %edi
               	jle	<addr>
               	movq	%rax, %rsi
               	movq	%rsi, %rax
               	andq	$0xff, %rax
               	movslq	%eax, %rax
               	retq

<join_byte_as_signed>:
               	xorl	%eax, %eax
               	testl	%edi, %edi
               	jle	<addr>
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	movsbq	%al, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x2a, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	$0x12c, %edi            # imm = 0x12C
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	$-0x1, %rdi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	callq	<addr>
               	cmpq	$0xbb, %rax
               	jne	<addr>
               	movl	$0x64, %edi
               	callq	<addr>
               	cmpq	$0x4c, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0xff, %edi
               	callq	<addr>
               	cmpq	$0xff, %rax
               	jne	<addr>
               	movl	$0x100, %edi            # imm = 0x100
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x12c, %edi            # imm = 0x12C
               	callq	<addr>
               	cmpq	$0x2c, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x2a, %edi
               	callq	<addr>
               	cmpq	$0x7e, %rax
               	jne	<addr>
               	movl	$0x2b, %edi
               	callq	<addr>
               	cmpq	$-0x7f, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x8, %rax
               	jne	<addr>
               	movl	$0x11170, %edi          # imm = 0x11170
               	callq	<addr>
               	cmpq	$0x1171, %rax           # imm = 0x1171
               	jne	<addr>
               	movl	$0xffff, %edi           # imm = 0xFFFF
               	callq	<addr>
               	cmpq	$0x10000, %rax          # imm = 0x10000
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movl	$0x1234, %esi           # imm = 0x1234
               	callq	<addr>
               	cmpq	$0x34, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	movl	$0x1234, %esi           # imm = 0x1234
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movq	$-0x2, %rsi
               	callq	<addr>
               	cmpq	$0xfe, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movl	$0x7f, %edi
               	callq	<addr>
               	cmpq	$0x7f, %rax
               	jne	<addr>
               	movl	$0x80, %edi
               	callq	<addr>
               	cmpq	$-0x80, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	movl	$0x1ff, %edi            # imm = 0x1FF
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movq	$-0x5, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	popq	%rbp
               	retq
