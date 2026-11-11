
atomic_orders.x64:	file format elf64-x86-64

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

<int_ops>:
               	leaq	<rip>, %rax # <addr>
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rsi
               	lock
               	xaddl	%esi, (%rax)
               	cmpl	$0xfffeee90, %esi       # imm = 0xFFFEEE90
               	jne	<addr>
               	movl	<rip>, %esi # <addr>
               	cmpl	$0xfffeee93, %esi       # imm = 0xFFFEEE93
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddl	%ecx, (%rax)
               	cmpl	$0xfffeee90, %ecx       # imm = 0xFFFEEE90
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee8d, %eax       # imm = 0xFFFEEE8D
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movl	$0x6, %esi
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee96, %eax       # imm = 0xFFFEEE96
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movl	$0x6, %esi
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee96, %eax       # imm = 0xFFFEEE96
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movl	$0x9, %eax
               	xchgl	%eax, (%rcx)
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rsi
               	lock
               	xaddl	%esi, (%rax)
               	addq	$0x3, %rsi
               	cmpl	$0xfffeee93, %esi       # imm = 0xFFFEEE93
               	jne	<addr>
               	movl	<rip>, %esi # <addr>
               	cmpl	$0xfffeee93, %esi       # imm = 0xFFFEEE93
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddl	%ecx, (%rax)
               	leaq	-0x3(%rcx), %rax
               	cmpl	$0xfffeee8d, %eax       # imm = 0xFFFEEE8D
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee8d, %eax       # imm = 0xFFFEEE8D
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movl	$0x6, %ecx
               	movl	(%rdx), %eax
               	movq	%rax, %r10
               	andq	%rcx, %r10
               	lock
               	cmpxchgl	%r10d, (%rdx)
               	jne	<addr>
               	andq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movl	(%rdx), %eax
               	movq	%rax, %r10
               	orq	%rcx, %r10
               	lock
               	cmpxchgl	%r10d, (%rdx)
               	jne	<addr>
               	orq	%rcx, %rax
               	cmpl	$0xfffeee96, %eax       # imm = 0xFFFEEE96
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee96, %eax       # imm = 0xFFFEEE96
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movl	$0x6, %esi
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	xorq	%rsi, %rax
               	cmpl	$0xfffeee96, %eax       # imm = 0xFFFEEE96
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee96, %eax       # imm = 0xFFFEEE96
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	lock
               	addl	$0x3, (%rcx)
               	lock
               	subl	$0x1, (%rcx)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee92, %eax       # imm = 0xFFFEEE92
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	lock
               	andl	$0xe, (%rcx)
               	lock
               	orl	$0x1, (%rcx)
               	lock
               	xorl	$0x3, (%rcx)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgl	%r10d, (%rcx)
               	leaq	<rip>, %rsi # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movq	$-0x11170, %rcx         # imm = 0xFFFEEE90
               	movl	%ecx, <rip> # <addr>
               	movl	$0x9, %edx
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edx, (%rsi)
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	cmovneq	%rcx, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	<rip>, %esi # <addr>
               	cmpl	$0x9, %esi
               	jne	<addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	%ecx, <rip> # <addr>
               	movq	$-0x1116f, %rcx         # imm = 0xFFFEEE91
               	leaq	<rip>, %rsi # <addr>
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edx, (%rsi)
               	cmpl	$0xfffeee91, %eax       # imm = 0xFFFEEE91
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	cmovneq	%rcx, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	movl	<rip>, %edx # <addr>
               	cmpl	$0xfffeee90, %edx       # imm = 0xFFFEEE90
               	jne	<addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x9, %edi
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edi, (%rsi)
               	cmpl	$0xfffeee91, %eax       # imm = 0xFFFEEE91
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	cmovneq	%rcx, %rax
               	testl	%edi, %edi
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0xfffeee90, %ecx       # imm = 0xFFFEEE90
               	jne	<addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movq	$-0x11170, %rcx         # imm = 0xFFFEEE90
               	movl	$0x9, %edx
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edx, (%rsi)
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movl	%ecx, <rip> # <addr>
               	movq	$-0x1116f, %rcx         # imm = 0xFFFEEE91
               	movl	%ecx, <rip> # <addr>
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edx, (%rsi)
               	cmpl	$0xfffeee91, %eax       # imm = 0xFFFEEE91
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movq	$-0x11170, %rdx         # imm = 0xFFFEEE90
               	movl	%edx, (%rsi)
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %esi
               	cmpl	$0xfffeee90, %esi       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	%ecx, (%rax)
               	movl	(%rax), %ecx
               	cmpl	$0xfffeee91, %ecx       # imm = 0xFFFEEE91
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	(%rax), %ecx
               	cmpl	$0xfffeee91, %ecx       # imm = 0xFFFEEE91
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movq	%rdx, %r10
               	xchgl	%r10d, (%rax)
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx), %eax
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0x3, %eax
               	movq	%rax, %rdx
               	lock
               	xaddl	%edx, (%rcx)
               	cmpl	$0xfffeee90, %edx       # imm = 0xFFFEEE90
               	jne	<addr>
               	movl	<rip>, %edx # <addr>
               	cmpl	$0xfffeee93, %edx       # imm = 0xFFFEEE93
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	negq	%rax
               	lock
               	xaddl	%eax, (%rcx)
               	subq	$0x3, %rax
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0x6, %edx
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee96, %eax       # imm = 0xFFFEEE96
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movq	$-0x11170, %rcx         # imm = 0xFFFEEE90
               	movl	%ecx, <rip> # <addr>
               	movl	$0x9, %esi
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%esi, (%rdx)
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0x8, %edi
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edi, (%rdx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movq	$-0x11170, %rdx         # imm = 0xFFFEEE90
               	movl	%esi, %eax
               	lock
               	cmpxchgl	%edx, (%rcx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0x9, %eax
               	movl	%eax, %eax
               	lock
               	cmpxchgl	%edi, (%rcx)
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0x7, %eax
               	xchgl	%eax, (%rcx)
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movl	%eax, (%rcx)
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	retq
               	movl	%eax, <rip> # <addr>
               	jmp	<addr>
               	movl	%eax, <rip> # <addr>
               	jmp	<addr>

<llong_ops>:
               	leaq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %rcx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rsi
               	lock
               	xaddq	%rsi, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rcx, <rip> # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddq	%rcx, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x6, %esi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x6, %esi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movl	$0x9, %eax
               	xchgq	%rax, (%rcx)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %rcx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rsi
               	lock
               	xaddq	%rsi, (%rax)
               	addq	$0x3, %rsi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rcx, <rip> # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddq	%rcx, (%rax)
               	leaq	-0x3(%rcx), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movl	$0x6, %ecx
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rcx, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	andq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rcx, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	orq	%rcx, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x6, %esi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	xorq	%rsi, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	lock
               	addq	$0x3, (%rcx)
               	lock
               	subq	$0x1, (%rcx)
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fe, %r11     # imm = 0xFFFFFFFED5FA0E02
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdi, <rip> # <addr>
               	lock
               	andq	$0xe, (%rcx)
               	lock
               	orq	$0x1, (%rcx)
               	lock
               	xorq	$0x3, (%rcx)
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdi, <rip> # <addr>
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgq	%r10, (%rcx)
               	leaq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x5, %rcx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rcx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rsi
               	lock
               	xaddq	%rsi, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rcx, <rip> # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddq	%rcx, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x6, %esi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x6, %esi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movl	$0x9, %eax
               	xchgq	%rax, (%rcx)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %rcx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rsi
               	lock
               	xaddq	%rsi, (%rax)
               	addq	$0x3, %rsi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rcx, <rip> # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddq	%rcx, (%rax)
               	leaq	-0x3(%rcx), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movl	$0x6, %ecx
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rcx, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	andq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rcx, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	orq	%rcx, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x6, %esi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	xorq	%rsi, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	lock
               	addq	$0x3, (%rcx)
               	lock
               	subq	$0x1, (%rcx)
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fe, %r11     # imm = 0xFFFFFFFED5FA0E02
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdi, <rip> # <addr>
               	lock
               	andq	$0xe, (%rcx)
               	lock
               	orq	$0x1, (%rcx)
               	lock
               	xorq	$0x3, (%rcx)
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdi, <rip> # <addr>
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgq	%r10, (%rcx)
               	leaq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x5, %rcx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rcx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rsi
               	lock
               	xaddq	%rsi, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rcx, <rip> # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddq	%rcx, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x6, %esi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x6, %esi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movl	$0x9, %eax
               	xchgq	%rax, (%rcx)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %rcx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rsi
               	lock
               	xaddq	%rsi, (%rax)
               	addq	$0x3, %rsi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rcx, <rip> # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddq	%rcx, (%rax)
               	leaq	-0x3(%rcx), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movl	$0x6, %ecx
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rcx, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	andq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rcx, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	orq	%rcx, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x6, %esi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	xorq	%rsi, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	lock
               	addq	$0x3, (%rcx)
               	lock
               	subq	$0x1, (%rcx)
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fe, %r11     # imm = 0xFFFFFFFED5FA0E02
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdi, <rip> # <addr>
               	lock
               	andq	$0xe, (%rcx)
               	lock
               	orq	$0x1, (%rcx)
               	lock
               	xorq	$0x3, (%rcx)
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdi, <rip> # <addr>
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgq	%r10, (%rcx)
               	leaq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x5, %rcx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rcx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rsi
               	lock
               	xaddq	%rsi, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rcx, <rip> # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddq	%rcx, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x6, %esi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x6, %esi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movl	$0x9, %eax
               	xchgq	%rax, (%rcx)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %rcx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rsi
               	lock
               	xaddq	%rsi, (%rax)
               	addq	$0x3, %rsi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rcx, <rip> # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddq	%rcx, (%rax)
               	leaq	-0x3(%rcx), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movl	$0x6, %ecx
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rcx, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	andq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rcx, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	orq	%rcx, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x6, %esi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	xorq	%rsi, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	lock
               	addq	$0x3, (%rcx)
               	lock
               	subq	$0x1, (%rcx)
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fe, %r11     # imm = 0xFFFFFFFED5FA0E02
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdi, <rip> # <addr>
               	lock
               	andq	$0xe, (%rcx)
               	lock
               	orq	$0x1, (%rcx)
               	lock
               	xorq	$0x3, (%rcx)
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdi, <rip> # <addr>
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgq	%r10, (%rcx)
               	leaq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x5, %rcx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rcx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rsi
               	lock
               	xaddq	%rsi, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rcx, <rip> # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddq	%rcx, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x6, %esi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x6, %esi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movl	$0x9, %eax
               	xchgq	%rax, (%rcx)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %rcx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rsi
               	lock
               	xaddq	%rsi, (%rax)
               	addq	$0x3, %rsi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rcx, <rip> # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddq	%rcx, (%rax)
               	leaq	-0x3(%rcx), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movl	$0x6, %ecx
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rcx, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	andq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rcx, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	orq	%rcx, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x6, %esi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	xorq	%rsi, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	lock
               	addq	$0x3, (%rcx)
               	lock
               	subq	$0x1, (%rcx)
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fe, %r11     # imm = 0xFFFFFFFED5FA0E02
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdi, <rip> # <addr>
               	lock
               	andq	$0xe, (%rcx)
               	lock
               	orq	$0x1, (%rcx)
               	lock
               	xorq	$0x3, (%rcx)
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdi, <rip> # <addr>
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgq	%r10, (%rcx)
               	leaq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x5, %rcx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rcx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rsi
               	lock
               	xaddq	%rsi, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rcx, <rip> # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddq	%rcx, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x6, %esi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x6, %esi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movl	$0x9, %eax
               	xchgq	%rax, (%rcx)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %rcx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rsi
               	lock
               	xaddq	%rsi, (%rax)
               	addq	$0x3, %rsi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rcx, <rip> # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddq	%rcx, (%rax)
               	leaq	-0x3(%rcx), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movl	$0x6, %ecx
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rcx, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	andq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rcx, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	orq	%rcx, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x6, %esi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	xorq	%rsi, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	lock
               	addq	$0x3, (%rcx)
               	lock
               	subq	$0x1, (%rcx)
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fe, %r11     # imm = 0xFFFFFFFED5FA0E02
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdi, <rip> # <addr>
               	lock
               	andq	$0xe, (%rcx)
               	lock
               	orq	$0x1, (%rcx)
               	lock
               	xorq	$0x3, (%rcx)
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdi, <rip> # <addr>
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgq	%r10, (%rcx)
               	leaq	<rip>, %rsi # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rcx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, <rip> # <addr>
               	movl	$0x9, %edx
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdx, (%rsi)
               	cmpq	%rcx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	cmovneq	%rcx, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	<rip>, %rsi # <addr>
               	cmpq	$0x9, %rsi
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rcx, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rcx     # imm = 0xFFFFFFFED5FA0E01
               	leaq	<rip>, %rsi # <addr>
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdx, (%rsi)
               	cmpq	%rcx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	cmovneq	%rcx, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x9, %edi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rcx, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	cmovneq	%rcx, %rax
               	testl	%edi, %edi
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movq	%rdx, <rip> # <addr>
               	movabsq	$-0x12a05f200, %rcx     # imm = 0xFFFFFFFED5FA0E00
               	movl	$0x9, %edx
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdx, (%rsi)
               	cmpq	%rcx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movq	%rcx, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rcx     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdx, (%rsi)
               	cmpq	%rcx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x9, %edi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	cmovneq	%rdx, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	<rip>, %rsi # <addr>
               	cmpq	$0x9, %rsi
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x9, %edi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rcx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	cmovneq	%rcx, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rcx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rdx     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	cmovneq	%rdx, %rax
               	testl	%esi, %esi
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x9, %esi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdx)
               	cmpq	%rcx, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rcx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rdx     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rdx, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdi)
               	cmpq	%rdx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rcx, <rip> # <addr>
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x9, %esi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdx)
               	cmpq	%rcx, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	cmovneq	%rcx, %rax
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x9, %rcx
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdi, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rcx     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdx)
               	cmpq	%rcx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	cmovneq	%rcx, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movq	%rdi, <rip> # <addr>
               	movl	$0x9, %edx
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdx, (%rsi)
               	cmpq	%rcx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	cmovneq	%rcx, %rax
               	testl	%esi, %esi
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rcx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdx, (%rsi)
               	cmpq	%rcx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rcx, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rcx     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rcx, <rip> # <addr>
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x9, %esi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdx)
               	cmpq	%rcx, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rcx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdx)
               	cmpq	%rcx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	cmovneq	%rcx, %rax
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	<rip>, %rdx # <addr>
               	cmpq	$0x9, %rdx
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movq	%rcx, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rcx     # imm = 0xFFFFFFFED5FA0E01
               	movl	$0x9, %edx
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdx, (%rsi)
               	cmpq	%rcx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	cmovneq	%rcx, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x9, %edi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rcx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	cmovneq	%rcx, %rax
               	testl	%esi, %esi
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movq	%rdx, <rip> # <addr>
               	movq	%rdx, <rip> # <addr>
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rcx)
               	cmpq	%rdx, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movabsq	$-0x12a05f200, %rcx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rdx     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rdx, <rip> # <addr>
               	movl	$0x9, %edi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rcx, <rip> # <addr>
               	movl	$0x9, %edx
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdx, (%rsi)
               	cmpq	%rcx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	cmovneq	%rcx, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x9, %rcx
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rcx     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdx, (%rdi)
               	cmpq	%rcx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	cmovneq	%rcx, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rcx     # imm = 0xFFFFFFFED5FA0E01
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x9, %esi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdx)
               	cmpq	%rcx, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	cmovneq	%rcx, %rax
               	testl	%edi, %edi
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rcx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdx)
               	cmpq	%rcx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movq	%rcx, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rcx     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rcx, <rip> # <addr>
               	movl	$0x9, %esi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdx)
               	cmpq	%rcx, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rcx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdx)
               	cmpq	%rcx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	cmovneq	%rcx, %rax
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	<rip>, %rdx # <addr>
               	cmpq	$0x9, %rdx
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movq	%rcx, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rcx     # imm = 0xFFFFFFFED5FA0E01
               	movl	$0x9, %edx
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdx, (%rsi)
               	cmpq	%rcx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	cmovneq	%rcx, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x9, %edi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rcx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	cmovneq	%rcx, %rax
               	testl	%esi, %esi
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movq	%rdx, <rip> # <addr>
               	movq	%rdx, <rip> # <addr>
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rcx)
               	cmpq	%rdx, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movabsq	$-0x12a05f200, %rcx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rdx     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rdx, <rip> # <addr>
               	movl	$0x9, %edi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rcx, <rip> # <addr>
               	movl	$0x9, %edx
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdx, (%rsi)
               	cmpq	%rcx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	cmovneq	%rcx, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x9, %rcx
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rcx     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdx, (%rdi)
               	cmpq	%rcx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	cmovneq	%rcx, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rcx     # imm = 0xFFFFFFFED5FA0E01
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x9, %esi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdx)
               	cmpq	%rcx, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	cmovneq	%rcx, %rax
               	testl	%edi, %edi
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rcx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdx)
               	cmpq	%rcx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movq	%rcx, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rcx     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rcx, <rip> # <addr>
               	movl	$0x9, %esi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdx)
               	cmpq	%rcx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testl	%esi, %esi
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, (%rdx)
               	movq	(%rdx), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	movabsq	$-0x12a05f1ff, %r11     # imm = 0xFFFFFFFED5FA0E01
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	(%rax), %rcx
               	movabsq	$-0x12a05f1ff, %r11     # imm = 0xFFFFFFFED5FA0E01
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, %r10
               	xchgq	%r10, (%rax)
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x3, %eax
               	movq	%rax, %rdx
               	lock
               	xaddq	%rdx, (%rcx)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	negq	%rax
               	lock
               	xaddq	%rax, (%rcx)
               	subq	$0x3, %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movl	$0x6, %edx
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %rcx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, <rip> # <addr>
               	movl	$0x9, %esi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdx)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movl	$0x8, %edi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdi, (%rdx)
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, %rax
               	lock
               	cmpxchgq	%rdx, (%rcx)
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movl	$0x9, %eax
               	lock
               	cmpxchgq	%rdi, (%rcx)
               	cmpq	$0x9, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movl	$0x7, %eax
               	xchgq	%rax, (%rcx)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movq	%rax, (%rcx)
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	retq
               	movq	%rax, <rip> # <addr>
               	jmp	<addr>
               	movq	%rax, <rip> # <addr>
               	jmp	<addr>
               	movq	%rax, <rip> # <addr>
               	jmp	<addr>
               	movq	%rax, <rip> # <addr>
               	jmp	<addr>
               	movq	%rax, <rip> # <addr>
               	jmp	<addr>
               	movq	%rax, <rip> # <addr>
               	jmp	<addr>
               	movq	%rax, <rip> # <addr>
               	jmp	<addr>
               	movq	%rax, <rip> # <addr>
               	jmp	<addr>
               	movq	%rax, <rip> # <addr>
               	jmp	<addr>
               	movq	%rax, <rip> # <addr>
               	jmp	<addr>
               	movq	%rax, <rip> # <addr>
               	jmp	<addr>
               	movq	%rax, <rip> # <addr>
               	jmp	<addr>
               	movq	%rax, <rip> # <addr>
               	jmp	<addr>
               	movq	%rax, <rip> # <addr>
               	jmp	<addr>

<schar_ops>:
               	leaq	<rip>, %rax # <addr>
               	movb	$-0x3, <rip> # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rsi
               	lock
               	xaddb	%sil, (%rax)
               	movsbq	%sil, %rsi
               	cmpl	$-0x3, %esi
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	$-0x3, <rip> # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddb	%cl, (%rax)
               	movsbq	%cl, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x6, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movb	$-0x3, <rip> # <addr>
               	movl	$0x6, %esi
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	$-0x3, <rip> # <addr>
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movb	$-0x3, <rip> # <addr>
               	movl	$0x6, %esi
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x5, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	$-0x3, <rip> # <addr>
               	movl	$0x9, %eax
               	xchgb	%al, (%rcx)
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movb	$-0x3, <rip> # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rsi
               	lock
               	xaddb	%sil, (%rax)
               	movsbq	%sil, %rsi
               	addq	$0x3, %rsi
               	movsbq	%sil, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	$-0x3, <rip> # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddb	%cl, (%rax)
               	movsbq	%cl, %rax
               	subq	$0x3, %rax
               	movsbq	%al, %rax
               	cmpl	$-0x6, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x6, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movb	$-0x3, <rip> # <addr>
               	movl	$0x6, %ecx
               	movzbq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rcx, %r10
               	lock
               	cmpxchgb	%r10b, (%rdx)
               	jne	<addr>
               	movsbq	%al, %rax
               	andq	%rcx, %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	$-0x3, <rip> # <addr>
               	movzbq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rcx, %r10
               	lock
               	cmpxchgb	%r10b, (%rdx)
               	jne	<addr>
               	movsbq	%al, %rax
               	orq	%rcx, %rax
               	movsbq	%al, %rax
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movb	$-0x3, <rip> # <addr>
               	movl	$0x6, %esi
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	movsbq	%al, %rax
               	xorq	%rsi, %rax
               	movsbq	%al, %rax
               	cmpl	$-0x5, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x5, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	$-0x3, <rip> # <addr>
               	lock
               	addb	$0x3, (%rcx)
               	lock
               	subb	$0x1, (%rcx)
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movb	$-0x3, <rip> # <addr>
               	lock
               	andb	$0xe, (%rcx)
               	lock
               	orb	$0x1, (%rcx)
               	lock
               	xorb	$0x3, (%rcx)
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0xe, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	$-0x3, <rip> # <addr>
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgb	%r10b, (%rcx)
               	leaq	<rip>, %rsi # <addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movq	$-0x3, %rcx
               	movb	%cl, <rip> # <addr>
               	movl	$0x9, %edx
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%dl, (%rsi)
               	cmpl	$0xfd, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	cmovneq	%rcx, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	<rip>, %rsi # <addr>
               	cmpl	$0x9, %esi
               	jne	<addr>
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	%cl, <rip> # <addr>
               	movq	$-0x2, %rcx
               	leaq	<rip>, %rsi # <addr>
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%dl, (%rsi)
               	cmpl	$0xfe, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	cmovneq	%rcx, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	movsbq	<rip>, %rdx # <addr>
               	cmpl	$-0x3, %edx
               	jne	<addr>
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	$-0x3, <rip> # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x9, %edi
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%dil, (%rsi)
               	cmpl	$0xfe, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	cmovneq	%rcx, %rax
               	testl	%edi, %edi
               	jne	<addr>
               	movsbq	<rip>, %rcx # <addr>
               	cmpl	$-0x3, %ecx
               	jne	<addr>
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	$-0x3, <rip> # <addr>
               	movb	$-0x3, <rip> # <addr>
               	movq	$-0x3, %rcx
               	movl	$0x9, %edx
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%dl, (%rsi)
               	cmpl	$0xfd, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movb	%cl, <rip> # <addr>
               	movq	$-0x2, %rcx
               	movb	%cl, <rip> # <addr>
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%dl, (%rsi)
               	cmpl	$0xfe, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movq	$-0x3, %rdx
               	movb	%dl, (%rsi)
               	leaq	<rip>, %rax # <addr>
               	movzbq	(%rax), %rsi
               	movsbq	%sil, %rsi
               	cmpl	$-0x3, %esi
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	%cl, (%rax)
               	movzbq	(%rax), %rcx
               	movsbq	%cl, %rcx
               	cmpl	$-0x2, %ecx
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movzbq	(%rax), %rcx
               	movsbq	%cl, %rcx
               	cmpl	$-0x2, %ecx
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movq	%rdx, %r10
               	xchgb	%r10b, (%rax)
               	leaq	<rip>, %rcx # <addr>
               	movzbq	(%rcx), %rax
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movl	$0x3, %eax
               	movq	%rax, %rdx
               	lock
               	xaddb	%dl, (%rcx)
               	movsbq	%dl, %rdx
               	cmpl	$-0x3, %edx
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	negq	%rax
               	lock
               	xaddb	%al, (%rcx)
               	movsbq	%al, %rax
               	subq	$0x3, %rax
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movl	$0x6, %edx
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x5, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movq	$-0x3, %rcx
               	movb	%cl, <rip> # <addr>
               	movl	$0x9, %esi
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%sil, (%rdx)
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movl	$0x8, %edi
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%dil, (%rdx)
               	movsbq	%al, %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movq	$-0x3, %rdx
               	movzbq	%sil, %rax
               	lock
               	cmpxchgb	%dl, (%rcx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movl	$0x9, %eax
               	movzbq	%al, %rax
               	lock
               	cmpxchgb	%dil, (%rcx)
               	cmpl	$0x9, %eax
               	je	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movl	$0x7, %eax
               	xchgb	%al, (%rcx)
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movb	%al, (%rcx)
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	retq
               	movb	%al, <rip> # <addr>
               	jmp	<addr>
               	movb	%al, <rip> # <addr>
               	jmp	<addr>

<uchar_ops>:
               	leaq	<rip>, %rax # <addr>
               	movb	$-0x6, <rip> # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rsi
               	lock
               	xaddb	%sil, (%rax)
               	andq	$0xff, %rsi
               	cmpl	$0xfa, %esi
               	jne	<addr>
               	movzbq	<rip>, %rsi # <addr>
               	cmpl	$0xfd, %esi
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	$-0x6, <rip> # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddb	%cl, (%rax)
               	andq	$0xff, %rcx
               	cmpl	$0xfa, %ecx
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xf7, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movb	$-0x6, <rip> # <addr>
               	movl	$0x6, %esi
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	andq	$0xff, %rax
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	$-0x6, <rip> # <addr>
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	andq	$0xff, %rax
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xfe, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movb	$-0x6, <rip> # <addr>
               	movl	$0x6, %esi
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	andq	$0xff, %rax
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xfc, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	$-0x6, <rip> # <addr>
               	movl	$0x9, %eax
               	xchgb	%al, (%rcx)
               	andq	$0xff, %rax
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movb	$-0x6, <rip> # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rsi
               	lock
               	xaddb	%sil, (%rax)
               	andq	$0xff, %rsi
               	addq	$0x3, %rsi
               	andq	$0xff, %rsi
               	cmpl	$0xfd, %esi
               	jne	<addr>
               	movzbq	<rip>, %rsi # <addr>
               	cmpl	$0xfd, %esi
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	$-0x6, <rip> # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddb	%cl, (%rax)
               	andq	$0xff, %rcx
               	leaq	-0x3(%rcx), %rax
               	andq	$0xff, %rax
               	cmpl	$0xf7, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xf7, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movb	$-0x6, <rip> # <addr>
               	movl	$0x6, %ecx
               	movzbq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rcx, %r10
               	lock
               	cmpxchgb	%r10b, (%rdx)
               	jne	<addr>
               	andq	$0xff, %rax
               	andq	%rcx, %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	$-0x6, <rip> # <addr>
               	movzbq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rcx, %r10
               	lock
               	cmpxchgb	%r10b, (%rdx)
               	jne	<addr>
               	andq	$0xff, %rax
               	orq	%rcx, %rax
               	cmpl	$0xfe, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xfe, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movb	$-0x6, <rip> # <addr>
               	movl	$0x6, %esi
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	andq	$0xff, %rax
               	xorq	%rsi, %rax
               	cmpl	$0xfc, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xfc, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	$-0x6, <rip> # <addr>
               	lock
               	addb	$0x3, (%rcx)
               	lock
               	subb	$0x1, (%rcx)
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xfc, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movb	$-0x6, <rip> # <addr>
               	lock
               	andb	$0xe, (%rcx)
               	lock
               	orb	$0x1, (%rcx)
               	lock
               	xorb	$0x3, (%rcx)
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	$-0x6, <rip> # <addr>
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgb	%r10b, (%rcx)
               	leaq	<rip>, %rsi # <addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movl	$0xfa, %ecx
               	movb	%cl, <rip> # <addr>
               	movl	$0x9, %edx
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%dl, (%rsi)
               	cmpl	$0xfa, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	cmovneq	%rcx, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	movzbq	<rip>, %rsi # <addr>
               	cmpl	$0x9, %esi
               	jne	<addr>
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	%cl, <rip> # <addr>
               	movl	$0xfb, %ecx
               	leaq	<rip>, %rsi # <addr>
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%dl, (%rsi)
               	cmpl	$0xfb, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	cmovneq	%rcx, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	<rip>, %rdx # <addr>
               	cmpl	$0xfa, %edx
               	jne	<addr>
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	$-0x6, <rip> # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x9, %edi
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%dil, (%rsi)
               	cmpl	$0xfb, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	cmovneq	%rcx, %rax
               	testl	%edi, %edi
               	jne	<addr>
               	movzbq	<rip>, %rcx # <addr>
               	cmpl	$0xfa, %ecx
               	jne	<addr>
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	$-0x6, <rip> # <addr>
               	movb	$-0x6, <rip> # <addr>
               	movl	$0xfa, %ecx
               	movl	$0x9, %edx
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%dl, (%rsi)
               	cmpl	$0xfa, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movb	%cl, <rip> # <addr>
               	movl	$0xfb, %ecx
               	movb	%cl, <rip> # <addr>
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%dl, (%rsi)
               	cmpl	$0xfb, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movl	$0xfa, %edx
               	movb	%dl, (%rsi)
               	leaq	<rip>, %rax # <addr>
               	movzbq	(%rax), %rsi
               	cmpl	$0xfa, %esi
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	%cl, (%rax)
               	movzbq	(%rax), %rcx
               	cmpl	$0xfb, %ecx
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movzbq	(%rax), %rcx
               	cmpl	$0xfb, %ecx
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movq	%rdx, %r10
               	xchgb	%r10b, (%rax)
               	leaq	<rip>, %rcx # <addr>
               	movzbq	(%rcx), %rax
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movl	$0x3, %eax
               	movq	%rax, %rdx
               	lock
               	xaddb	%dl, (%rcx)
               	andq	$0xff, %rdx
               	cmpl	$0xfa, %edx
               	jne	<addr>
               	movzbq	<rip>, %rdx # <addr>
               	cmpl	$0xfd, %edx
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	negq	%rax
               	lock
               	xaddb	%al, (%rcx)
               	andq	$0xff, %rax
               	subq	$0x3, %rax
               	andq	$0xff, %rax
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movl	$0x6, %edx
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	andq	$0xff, %rax
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xfc, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movl	$0xfa, %ecx
               	movb	%cl, <rip> # <addr>
               	movl	$0x9, %esi
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%sil, (%rdx)
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movl	$0x8, %edi
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%dil, (%rdx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0xfa, %edx
               	movzbq	%sil, %rax
               	lock
               	cmpxchgb	%dl, (%rcx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movl	$0x9, %eax
               	movzbq	%al, %rax
               	lock
               	cmpxchgb	%dil, (%rcx)
               	cmpl	$0x9, %eax
               	je	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movl	$0x7, %eax
               	xchgb	%al, (%rcx)
               	andq	$0xff, %rax
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movb	%al, (%rcx)
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	retq
               	movb	%al, <rip> # <addr>
               	jmp	<addr>
               	movb	%al, <rip> # <addr>
               	jmp	<addr>

<short_ops>:
               	leaq	<rip>, %rax # <addr>
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rsi
               	lock
               	xaddw	%si, (%rax)
               	movswq	%si, %rsi
               	cmpl	$0xfffffed4, %esi       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	<rip>, %rsi # <addr>
               	cmpl	$0xfffffed7, %esi       # imm = 0xFFFFFED7
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddw	%cx, (%rax)
               	movswq	%cx, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed1, %eax       # imm = 0xFFFFFED1
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movl	$0x6, %esi
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed6, %eax       # imm = 0xFFFFFED6
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movl	$0x6, %esi
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed2, %eax       # imm = 0xFFFFFED2
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movl	$0x9, %eax
               	xchgw	%ax, (%rcx)
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rsi
               	lock
               	xaddw	%si, (%rax)
               	movswq	%si, %rsi
               	addq	$0x3, %rsi
               	movswq	%si, %rsi
               	cmpl	$0xfffffed7, %esi       # imm = 0xFFFFFED7
               	jne	<addr>
               	movswq	<rip>, %rsi # <addr>
               	cmpl	$0xfffffed7, %esi       # imm = 0xFFFFFED7
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddw	%cx, (%rax)
               	movswq	%cx, %rax
               	subq	$0x3, %rax
               	movswq	%ax, %rax
               	cmpl	$0xfffffed1, %eax       # imm = 0xFFFFFED1
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed1, %eax       # imm = 0xFFFFFED1
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movl	$0x6, %ecx
               	movzwq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rcx, %r10
               	lock
               	cmpxchgw	%r10w, (%rdx)
               	jne	<addr>
               	movswq	%ax, %rax
               	andq	%rcx, %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movzwq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rcx, %r10
               	lock
               	cmpxchgw	%r10w, (%rdx)
               	jne	<addr>
               	movswq	%ax, %rax
               	orq	%rcx, %rax
               	movswq	%ax, %rax
               	cmpl	$0xfffffed6, %eax       # imm = 0xFFFFFED6
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed6, %eax       # imm = 0xFFFFFED6
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movl	$0x6, %esi
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	movswq	%ax, %rax
               	xorq	%rsi, %rax
               	movswq	%ax, %rax
               	cmpl	$0xfffffed2, %eax       # imm = 0xFFFFFED2
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed2, %eax       # imm = 0xFFFFFED2
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	lock
               	addw	$0x3, (%rcx)
               	lock
               	subw	$0x1, (%rcx)
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed6, %eax       # imm = 0xFFFFFED6
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	lock
               	andw	$0xe, (%rcx)
               	lock
               	orw	$0x1, (%rcx)
               	lock
               	xorw	$0x3, (%rcx)
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgw	%r10w, (%rcx)
               	leaq	<rip>, %rsi # <addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movq	$-0x12c, %rcx           # imm = 0xFED4
               	movw	%cx, <rip> # <addr>
               	movl	$0x9, %edx
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%dx, (%rsi)
               	cmpl	$0xfed4, %eax           # imm = 0xFED4
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	cmovneq	%rcx, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	movswq	<rip>, %rsi # <addr>
               	cmpl	$0x9, %esi
               	jne	<addr>
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	%cx, <rip> # <addr>
               	movq	$-0x12b, %rcx           # imm = 0xFED5
               	leaq	<rip>, %rsi # <addr>
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%dx, (%rsi)
               	cmpl	$0xfed5, %eax           # imm = 0xFED5
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	cmovneq	%rcx, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	movswq	<rip>, %rdx # <addr>
               	cmpl	$0xfffffed4, %edx       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x9, %edi
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%di, (%rsi)
               	cmpl	$0xfed5, %eax           # imm = 0xFED5
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	cmovneq	%rcx, %rax
               	testl	%edi, %edi
               	jne	<addr>
               	movswq	<rip>, %rcx # <addr>
               	cmpl	$0xfffffed4, %ecx       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movq	$-0x12c, %rcx           # imm = 0xFED4
               	movl	$0x9, %edx
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%dx, (%rsi)
               	cmpl	$0xfed4, %eax           # imm = 0xFED4
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movw	%cx, <rip> # <addr>
               	movq	$-0x12b, %rcx           # imm = 0xFED5
               	movw	%cx, <rip> # <addr>
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%dx, (%rsi)
               	cmpl	$0xfed5, %eax           # imm = 0xFED5
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movq	$-0x12c, %rdx           # imm = 0xFED4
               	movw	%dx, (%rsi)
               	leaq	<rip>, %rax # <addr>
               	movzwq	(%rax), %rsi
               	movswq	%si, %rsi
               	cmpl	$0xfffffed4, %esi       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	%cx, (%rax)
               	movzwq	(%rax), %rcx
               	movswq	%cx, %rcx
               	cmpl	$0xfffffed5, %ecx       # imm = 0xFFFFFED5
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movzwq	(%rax), %rcx
               	movswq	%cx, %rcx
               	cmpl	$0xfffffed5, %ecx       # imm = 0xFFFFFED5
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movq	%rdx, %r10
               	xchgw	%r10w, (%rax)
               	leaq	<rip>, %rcx # <addr>
               	movzwq	(%rcx), %rax
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movl	$0x3, %eax
               	movq	%rax, %rdx
               	lock
               	xaddw	%dx, (%rcx)
               	movswq	%dx, %rdx
               	cmpl	$0xfffffed4, %edx       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	<rip>, %rdx # <addr>
               	cmpl	$0xfffffed7, %edx       # imm = 0xFFFFFED7
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	negq	%rax
               	lock
               	xaddw	%ax, (%rcx)
               	movswq	%ax, %rax
               	subq	$0x3, %rax
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movl	$0x6, %edx
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed2, %eax       # imm = 0xFFFFFED2
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movq	$-0x12c, %rcx           # imm = 0xFED4
               	movw	%cx, <rip> # <addr>
               	movl	$0x9, %esi
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%si, (%rdx)
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movl	$0x8, %edi
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%di, (%rdx)
               	movswq	%ax, %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movq	$-0x12c, %rdx           # imm = 0xFED4
               	movzwl	%si, %eax
               	lock
               	cmpxchgw	%dx, (%rcx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movl	$0x9, %eax
               	movzwl	%ax, %eax
               	lock
               	cmpxchgw	%di, (%rcx)
               	cmpl	$0x9, %eax
               	je	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movl	$0x7, %eax
               	xchgw	%ax, (%rcx)
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movw	%ax, (%rcx)
               	cmpw	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	retq
               	movw	%ax, <rip> # <addr>
               	jmp	<addr>
               	movw	%ax, <rip> # <addr>
               	jmp	<addr>

<ushort_ops>:
               	leaq	<rip>, %rax # <addr>
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rsi
               	lock
               	xaddw	%si, (%rax)
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	cmpl	$0xfde8, %esi           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	<rip>, %rsi # <addr>
               	cmpl	$0xfdeb, %esi           # imm = 0xFDEB
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddw	%cx, (%rax)
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	cmpl	$0xfde8, %ecx           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfde5, %eax           # imm = 0xFDE5
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movl	$0x6, %esi
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	cmpw	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfdee, %eax           # imm = 0xFDEE
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movl	$0x6, %esi
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfdee, %eax           # imm = 0xFDEE
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movl	$0x9, %eax
               	xchgw	%ax, (%rcx)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rsi
               	lock
               	xaddw	%si, (%rax)
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	addq	$0x3, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	cmpl	$0xfdeb, %esi           # imm = 0xFDEB
               	jne	<addr>
               	movzwq	<rip>, %rsi # <addr>
               	cmpl	$0xfdeb, %esi           # imm = 0xFDEB
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddw	%cx, (%rax)
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	leaq	-0x3(%rcx), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xfde5, %eax           # imm = 0xFDE5
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfde5, %eax           # imm = 0xFDE5
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movl	$0x6, %ecx
               	movzwq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rcx, %r10
               	lock
               	cmpxchgw	%r10w, (%rdx)
               	jne	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpw	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movzwq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rcx, %r10
               	lock
               	cmpxchgw	%r10w, (%rdx)
               	jne	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	orq	%rcx, %rax
               	cmpl	$0xfdee, %eax           # imm = 0xFDEE
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfdee, %eax           # imm = 0xFDEE
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movl	$0x6, %esi
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	%rsi, %rax
               	cmpl	$0xfdee, %eax           # imm = 0xFDEE
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfdee, %eax           # imm = 0xFDEE
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	lock
               	addw	$0x3, (%rcx)
               	lock
               	subw	$0x1, (%rcx)
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfdea, %eax           # imm = 0xFDEA
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	lock
               	andw	$0xe, (%rcx)
               	lock
               	orw	$0x1, (%rcx)
               	lock
               	xorw	$0x3, (%rcx)
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgw	%r10w, (%rcx)
               	leaq	<rip>, %rsi # <addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movl	$0xfde8, %ecx           # imm = 0xFDE8
               	movw	%cx, <rip> # <addr>
               	movl	$0x9, %edx
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%dx, (%rsi)
               	cmpl	%ecx, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	cmovneq	%rcx, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	movzwq	<rip>, %rsi # <addr>
               	cmpl	$0x9, %esi
               	jne	<addr>
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	%cx, <rip> # <addr>
               	movl	$0xfde9, %ecx           # imm = 0xFDE9
               	leaq	<rip>, %rsi # <addr>
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%dx, (%rsi)
               	cmpl	%ecx, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	cmovneq	%rcx, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	movzwq	<rip>, %rdx # <addr>
               	cmpl	$0xfde8, %edx           # imm = 0xFDE8
               	jne	<addr>
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x9, %edi
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%di, (%rsi)
               	cmpl	%ecx, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	cmovneq	%rcx, %rax
               	testl	%edi, %edi
               	jne	<addr>
               	movzwq	<rip>, %rcx # <addr>
               	cmpl	$0xfde8, %ecx           # imm = 0xFDE8
               	jne	<addr>
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movl	$0xfde8, %ecx           # imm = 0xFDE8
               	movl	$0x9, %edx
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%dx, (%rsi)
               	cmpl	%ecx, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movw	%cx, <rip> # <addr>
               	movl	$0xfde9, %ecx           # imm = 0xFDE9
               	movw	%cx, <rip> # <addr>
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%dx, (%rsi)
               	cmpl	%ecx, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movl	$0xfde8, %edx           # imm = 0xFDE8
               	movw	%dx, (%rsi)
               	leaq	<rip>, %rax # <addr>
               	movzwq	(%rax), %rsi
               	cmpl	$0xfde8, %esi           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	%cx, (%rax)
               	movzwq	(%rax), %rcx
               	cmpl	$0xfde9, %ecx           # imm = 0xFDE9
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movzwq	(%rax), %rcx
               	cmpl	$0xfde9, %ecx           # imm = 0xFDE9
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movq	%rdx, %r10
               	xchgw	%r10w, (%rax)
               	leaq	<rip>, %rcx # <addr>
               	movzwq	(%rcx), %rax
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movl	$0x3, %eax
               	movq	%rax, %rdx
               	lock
               	xaddw	%dx, (%rcx)
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	cmpl	$0xfde8, %edx           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	<rip>, %rdx # <addr>
               	cmpl	$0xfdeb, %edx           # imm = 0xFDEB
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	negq	%rax
               	lock
               	xaddw	%ax, (%rcx)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	subq	$0x3, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movl	$0x6, %edx
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfdee, %eax           # imm = 0xFDEE
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movl	$0xfde8, %ecx           # imm = 0xFDE8
               	movw	%cx, <rip> # <addr>
               	movl	$0x9, %esi
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%si, (%rdx)
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movl	$0x8, %edi
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%di, (%rdx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0xfde8, %edx           # imm = 0xFDE8
               	movzwl	%si, %eax
               	lock
               	cmpxchgw	%dx, (%rcx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movl	$0x9, %eax
               	movzwl	%ax, %eax
               	lock
               	cmpxchgw	%di, (%rcx)
               	cmpl	$0x9, %eax
               	je	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movl	$0x7, %eax
               	xchgw	%ax, (%rcx)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movw	%ax, (%rcx)
               	cmpw	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	retq
               	movw	%ax, <rip> # <addr>
               	jmp	<addr>
               	movw	%ax, <rip> # <addr>
               	jmp	<addr>

<uint_ops>:
               	leaq	<rip>, %rax # <addr>
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rsi
               	lock
               	xaddl	%esi, (%rax)
               	cmpl	$0xee6b2800, %esi       # imm = 0xEE6B2800
               	jne	<addr>
               	movl	<rip>, %esi # <addr>
               	cmpl	$0xee6b2803, %esi       # imm = 0xEE6B2803
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddl	%ecx, (%rax)
               	cmpl	$0xee6b2800, %ecx       # imm = 0xEE6B2800
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xee6b27fd, %eax       # imm = 0xEE6B27FD
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movl	$0x6, %esi
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0xee6b2800, %eax       # imm = 0xEE6B2800
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0xee6b2800, %eax       # imm = 0xEE6B2800
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xee6b2806, %eax       # imm = 0xEE6B2806
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movl	$0x6, %esi
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0xee6b2800, %eax       # imm = 0xEE6B2800
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xee6b2806, %eax       # imm = 0xEE6B2806
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movl	$0x9, %eax
               	xchgl	%eax, (%rcx)
               	cmpl	$0xee6b2800, %eax       # imm = 0xEE6B2800
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rsi
               	lock
               	xaddl	%esi, (%rax)
               	addq	$0x3, %rsi
               	cmpl	$0xee6b2803, %esi       # imm = 0xEE6B2803
               	jne	<addr>
               	movl	<rip>, %esi # <addr>
               	cmpl	$0xee6b2803, %esi       # imm = 0xEE6B2803
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddl	%ecx, (%rax)
               	leaq	-0x3(%rcx), %rax
               	cmpl	$0xee6b27fd, %eax       # imm = 0xEE6B27FD
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xee6b27fd, %eax       # imm = 0xEE6B27FD
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movl	$0x6, %ecx
               	movl	(%rdx), %eax
               	movq	%rax, %r10
               	andq	%rcx, %r10
               	lock
               	cmpxchgl	%r10d, (%rdx)
               	jne	<addr>
               	andq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movl	(%rdx), %eax
               	movq	%rax, %r10
               	orq	%rcx, %r10
               	lock
               	cmpxchgl	%r10d, (%rdx)
               	jne	<addr>
               	orq	%rcx, %rax
               	cmpl	$0xee6b2806, %eax       # imm = 0xEE6B2806
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xee6b2806, %eax       # imm = 0xEE6B2806
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movl	$0x6, %esi
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	xorq	%rsi, %rax
               	cmpl	$0xee6b2806, %eax       # imm = 0xEE6B2806
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xee6b2806, %eax       # imm = 0xEE6B2806
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	lock
               	addl	$0x3, (%rcx)
               	lock
               	subl	$0x1, (%rcx)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xee6b2802, %eax       # imm = 0xEE6B2802
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	lock
               	andl	$0xe, (%rcx)
               	lock
               	orl	$0x1, (%rcx)
               	lock
               	xorl	$0x3, (%rcx)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgl	%r10d, (%rcx)
               	leaq	<rip>, %rsi # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, %ecx       # imm = 0xEE6B2800
               	movl	%ecx, <rip> # <addr>
               	movl	$0x9, %edx
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edx, (%rsi)
               	cmpl	%ecx, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	cmovneq	%rcx, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	<rip>, %esi # <addr>
               	cmpl	$0x9, %esi
               	jne	<addr>
               	cmpl	$0xee6b2800, %eax       # imm = 0xEE6B2800
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	%ecx, <rip> # <addr>
               	movl	$0xee6b2801, %ecx       # imm = 0xEE6B2801
               	leaq	<rip>, %rsi # <addr>
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edx, (%rsi)
               	cmpl	%ecx, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	cmovneq	%rcx, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	movl	<rip>, %edx # <addr>
               	cmpl	$0xee6b2800, %edx       # imm = 0xEE6B2800
               	jne	<addr>
               	cmpl	$0xee6b2800, %eax       # imm = 0xEE6B2800
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x9, %edi
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edi, (%rsi)
               	cmpl	%ecx, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	cmovneq	%rcx, %rax
               	testl	%edi, %edi
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0xee6b2800, %ecx       # imm = 0xEE6B2800
               	jne	<addr>
               	cmpl	$0xee6b2800, %eax       # imm = 0xEE6B2800
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movl	$0xee6b2800, %ecx       # imm = 0xEE6B2800
               	movl	$0x9, %edx
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edx, (%rsi)
               	cmpl	%ecx, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xee6b2800, %eax       # imm = 0xEE6B2800
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movl	%ecx, <rip> # <addr>
               	movl	$0xee6b2801, %ecx       # imm = 0xEE6B2801
               	movl	%ecx, <rip> # <addr>
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edx, (%rsi)
               	cmpl	%ecx, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xee6b2800, %eax       # imm = 0xEE6B2800
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xee6b2800, %eax       # imm = 0xEE6B2800
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, %edx       # imm = 0xEE6B2800
               	movl	%edx, (%rsi)
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %esi
               	cmpl	$0xee6b2800, %esi       # imm = 0xEE6B2800
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	%ecx, (%rax)
               	movl	(%rax), %ecx
               	cmpl	$0xee6b2801, %ecx       # imm = 0xEE6B2801
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	(%rax), %ecx
               	cmpl	$0xee6b2801, %ecx       # imm = 0xEE6B2801
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movq	%rdx, %r10
               	xchgl	%r10d, (%rax)
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx), %eax
               	cmpl	$0xee6b2800, %eax       # imm = 0xEE6B2800
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0x3, %eax
               	movq	%rax, %rdx
               	lock
               	xaddl	%edx, (%rcx)
               	cmpl	$0xee6b2800, %edx       # imm = 0xEE6B2800
               	jne	<addr>
               	movl	<rip>, %edx # <addr>
               	cmpl	$0xee6b2803, %edx       # imm = 0xEE6B2803
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	negq	%rax
               	lock
               	xaddl	%eax, (%rcx)
               	subq	$0x3, %rax
               	cmpl	$0xee6b2800, %eax       # imm = 0xEE6B2800
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xee6b2800, %eax       # imm = 0xEE6B2800
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0x6, %edx
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0xee6b2800, %eax       # imm = 0xEE6B2800
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xee6b2806, %eax       # imm = 0xEE6B2806
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movl	$0xee6b2800, %ecx       # imm = 0xEE6B2800
               	movl	%ecx, <rip> # <addr>
               	movl	$0x9, %esi
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%esi, (%rdx)
               	cmpl	$0xee6b2800, %eax       # imm = 0xEE6B2800
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0x8, %edi
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edi, (%rdx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0xee6b2800, %edx       # imm = 0xEE6B2800
               	movl	%esi, %eax
               	lock
               	cmpxchgl	%edx, (%rcx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xee6b2800, %eax       # imm = 0xEE6B2800
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0x9, %eax
               	movl	%eax, %eax
               	lock
               	cmpxchgl	%edi, (%rcx)
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xee6b2800, %eax       # imm = 0xEE6B2800
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0x7, %eax
               	xchgl	%eax, (%rcx)
               	cmpl	$0xee6b2800, %eax       # imm = 0xEE6B2800
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movl	%eax, (%rcx)
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	retq
               	movl	%eax, <rip> # <addr>
               	jmp	<addr>
               	movl	%eax, <rip> # <addr>
               	jmp	<addr>

<ullong_ops>:
               	leaq	<rip>, %rax # <addr>
               	movabsq	$-0x7000000000000000, %rcx # imm = 0x9000000000000000
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rsi
               	lock
               	xaddq	%rsi, (%rax)
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	movabsq	$-0x6ffffffffffffffd, %r11 # imm = 0x9000000000000003
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rcx, <rip> # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddq	%rcx, (%rax)
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x7000000000000003, %r11 # imm = 0x8FFFFFFFFFFFFFFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x7000000000000000, %rdx # imm = 0x9000000000000000
               	movq	%rdx, <rip> # <addr>
               	movl	$0x6, %esi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x6ffffffffffffffa, %r11 # imm = 0x9000000000000006
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x7000000000000000, %rdx # imm = 0x9000000000000000
               	movq	%rdx, <rip> # <addr>
               	movl	$0x6, %esi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x6ffffffffffffffa, %r11 # imm = 0x9000000000000006
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movl	$0x9, %eax
               	xchgq	%rax, (%rcx)
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movabsq	$-0x7000000000000000, %rcx # imm = 0x9000000000000000
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rsi
               	lock
               	xaddq	%rsi, (%rax)
               	addq	$0x3, %rsi
               	movabsq	$-0x6ffffffffffffffd, %r11 # imm = 0x9000000000000003
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	movabsq	$-0x6ffffffffffffffd, %r11 # imm = 0x9000000000000003
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rcx, <rip> # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddq	%rcx, (%rax)
               	leaq	-0x3(%rcx), %rax
               	movabsq	$-0x7000000000000003, %r11 # imm = 0x8FFFFFFFFFFFFFFD
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x7000000000000003, %r11 # imm = 0x8FFFFFFFFFFFFFFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x7000000000000000, %rsi # imm = 0x9000000000000000
               	movq	%rsi, <rip> # <addr>
               	movl	$0x6, %ecx
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rcx, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	andq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rcx, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	orq	%rcx, %rax
               	movabsq	$-0x6ffffffffffffffa, %r11 # imm = 0x9000000000000006
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x6ffffffffffffffa, %r11 # imm = 0x9000000000000006
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x7000000000000000, %rdx # imm = 0x9000000000000000
               	movq	%rdx, <rip> # <addr>
               	movl	$0x6, %esi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	xorq	%rsi, %rax
               	movabsq	$-0x6ffffffffffffffa, %r11 # imm = 0x9000000000000006
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x6ffffffffffffffa, %r11 # imm = 0x9000000000000006
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	lock
               	addq	$0x3, (%rcx)
               	lock
               	subq	$0x1, (%rcx)
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x6ffffffffffffffe, %r11 # imm = 0x9000000000000002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x7000000000000000, %rdi # imm = 0x9000000000000000
               	movq	%rdi, <rip> # <addr>
               	lock
               	andq	$0xe, (%rcx)
               	lock
               	orq	$0x1, (%rcx)
               	lock
               	xorq	$0x3, (%rcx)
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rdi, <rip> # <addr>
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgq	%r10, (%rcx)
               	leaq	<rip>, %rsi # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movabsq	$-0x7000000000000000, %rcx # imm = 0x9000000000000000
               	movq	%rcx, <rip> # <addr>
               	movl	$0x9, %edx
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdx, (%rsi)
               	cmpq	%rcx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	cmovneq	%rcx, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	<rip>, %rsi # <addr>
               	cmpq	$0x9, %rsi
               	jne	<addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rcx, <rip> # <addr>
               	movabsq	$-0x6fffffffffffffff, %rcx # imm = 0x9000000000000001
               	leaq	<rip>, %rsi # <addr>
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdx, (%rsi)
               	cmpq	%rcx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	cmovneq	%rcx, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movabsq	$-0x7000000000000000, %rdx # imm = 0x9000000000000000
               	movq	%rdx, <rip> # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x9, %edi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rcx, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	cmovneq	%rcx, %rax
               	testl	%edi, %edi
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movq	%rdx, <rip> # <addr>
               	movabsq	$-0x7000000000000000, %rcx # imm = 0x9000000000000000
               	movl	$0x9, %edx
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdx, (%rsi)
               	cmpq	%rcx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movq	%rcx, <rip> # <addr>
               	movabsq	$-0x6fffffffffffffff, %rcx # imm = 0x9000000000000001
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdx, (%rsi)
               	cmpq	%rcx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movabsq	$-0x7000000000000000, %rdx # imm = 0x9000000000000000
               	movq	%rdx, (%rsi)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rsi
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	movabsq	$-0x6fffffffffffffff, %r11 # imm = 0x9000000000000001
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	(%rax), %rcx
               	movabsq	$-0x6fffffffffffffff, %r11 # imm = 0x9000000000000001
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rdx, %r10
               	xchgq	%r10, (%rax)
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %rax
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movl	$0x3, %eax
               	movq	%rax, %rdx
               	lock
               	xaddq	%rdx, (%rcx)
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	movabsq	$-0x6ffffffffffffffd, %r11 # imm = 0x9000000000000003
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	negq	%rax
               	lock
               	xaddq	%rax, (%rcx)
               	subq	$0x3, %rax
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movl	$0x6, %edx
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x6ffffffffffffffa, %r11 # imm = 0x9000000000000006
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x7000000000000000, %rcx # imm = 0x9000000000000000
               	movq	%rcx, <rip> # <addr>
               	movl	$0x9, %esi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdx)
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movl	$0x8, %edi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdi, (%rdx)
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x7000000000000000, %rdx # imm = 0x9000000000000000
               	movq	%rsi, %rax
               	lock
               	cmpxchgq	%rdx, (%rcx)
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movl	$0x9, %eax
               	lock
               	cmpxchgq	%rdi, (%rcx)
               	cmpq	$0x9, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movl	$0x7, %eax
               	xchgq	%rax, (%rcx)
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movq	%rax, (%rcx)
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	retq
               	movq	%rax, <rip> # <addr>
               	jmp	<addr>
               	movq	%rax, <rip> # <addr>
               	jmp	<addr>

<other_ops>:
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rcx # <addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x4(%rcx), %rdi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rcx, %rax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	movq	%rax, %rdx
               	cmovneq	%rcx, %rdx
               	testq	%r8, %r8
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	%rdi, %rax
               	je	<addr>
               	movl	$0xa6, %eax
               	retq
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rcx, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	cmovneq	%rdx, %rax
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x4, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xa7, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, %rdx
               	xchgq	%rdx, (%rcx)
               	leaq	0x4(%rax), %rcx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0xa8, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0xa, <rip> # <addr>
               	movl	$0x5, %esi
               	movq	%rsi, %rax
               	lock
               	xaddl	%eax, (%rcx)
               	cmpl	$0xa, %eax
               	jne	<addr>
               	movl	(%rcx), %eax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0xab, %eax
               	retq
               	movl	$0x3, %eax
               	negq	%rax
               	lock
               	xaddl	%eax, (%rcx)
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0xac, %eax
               	retq
               	movl	$0x40, %edx
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	orq	%rdx, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0xad, %eax
               	retq
               	movl	$0x48, %edx
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	andq	%rdx, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0x4c, %eax
               	je	<addr>
               	movl	$0xae, %eax
               	retq
               	movl	$0x1, %edx
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0x48, %eax
               	je	<addr>
               	movl	$0xaf, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movq	$-0x1, %rdx
               	movq	%rdx, %rax
               	xchgl	%eax, (%rcx)
               	cmpl	$0x49, %eax
               	je	<addr>
               	movl	$0xb0, %eax
               	retq
               	movl	$0x4, %edi
               	movl	%edx, %eax
               	lock
               	cmpxchgl	%edi, (%rcx)
               	cmpl	$-0x1, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	cmoveq	%rax, %rdx
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	(%rcx), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0xb2, %eax
               	retq
               	movl	%edx, %eax
               	lock
               	cmpxchgl	%esi, (%rcx)
               	cmpl	%edx, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	cmovneq	%rdx, %rax
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0xb3, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, (%rcx)
               	movl	$0x7, %esi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rsi, (%rcx)
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0xb8, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x1, %edx
               	movq	%rdx, %rax
               	xchgb	%al, (%rcx)
               	movsbq	%al, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xbc, %eax
               	retq
               	movq	%rdx, %rax
               	xchgb	%al, (%rcx)
               	movsbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0xbd, %eax
               	retq
               	xorl	%eax, %eax
               	movb	%al, (%rcx)
               	xchgb	%dl, (%rcx)
               	movsbq	%dl, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0xbf, %eax
               	retq
               	movq	%rax, %r10
               	xchgb	%r10b, (%rcx)
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x1, %edx
               	movq	%rdx, %rsi
               	xchgb	%sil, (%rcx)
               	testb	$-0x1, %sil
               	jne	<addr>
               	xchgb	%dl, (%rcx)
               	testb	$-0x1, %dl
               	jne	<addr>
               	movl	$0xc1, %eax
               	retq
               	movb	%al, (%rcx)
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0xc3, %eax
               	retq
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
