
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
               	retq

<join_masked>:
               	xorl	%eax, %eax
               	cmpl	$0x80, %edi
               	jae	<addr>
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	xorq	$0x2a, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
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
               	movq	%rcx, %rax
               	retq

<count_s8>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%edi, %eax
               	jge	<addr>
               	addq	$0x3, %rcx
               	movsbq	%cl, %rcx
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
               	retq

<join_unmasked>:
               	movq	%rsi, %rax
               	xorl	%esi, %esi
               	testl	%edi, %edi
               	jle	<addr>
               	movq	%rax, %rsi
               	movq	%rsi, %rax
               	andq	$0xff, %rax
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
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7, %edi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x12c, %edi            # imm = 0x12C
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	$-0x1, %rdi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	callq	<addr>
               	cmpl	$0xbb, %eax
               	jne	<addr>
               	movl	$0x64, %edi
               	callq	<addr>
               	cmpl	$0x4c, %eax
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0xff, %edi
               	callq	<addr>
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movl	$0x100, %edi            # imm = 0x100
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x12c, %edi            # imm = 0x12C
               	callq	<addr>
               	cmpl	$0x2c, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x2a, %edi
               	callq	<addr>
               	cmpl	$0x7e, %eax
               	jne	<addr>
               	movl	$0x2b, %edi
               	callq	<addr>
               	cmpl	$-0x7f, %eax
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movl	$0x11170, %edi          # imm = 0x11170
               	callq	<addr>
               	cmpl	$0x1171, %eax           # imm = 0x1171
               	jne	<addr>
               	movl	$0xffff, %edi           # imm = 0xFFFF
               	callq	<addr>
               	cmpl	$0x10000, %eax          # imm = 0x10000
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movl	$0x1234, %esi           # imm = 0x1234
               	callq	<addr>
               	cmpl	$0x34, %eax
               	jne	<addr>
               	xorl	%edi, %edi
               	movl	$0x1234, %esi           # imm = 0x1234
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movq	$-0x2, %rsi
               	callq	<addr>
               	cmpl	$0xfe, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movl	$0x7f, %edi
               	callq	<addr>
               	cmpl	$0x7f, %eax
               	jne	<addr>
               	movl	$0x80, %edi
               	callq	<addr>
               	cmpl	$-0x80, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	movl	$0x1ff, %edi            # imm = 0x1FF
               	callq	<addr>
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	movq	$-0x5, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	popq	%rbp
               	retq
